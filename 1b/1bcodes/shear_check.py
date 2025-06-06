import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os
def mohr_coulomb_shear_strength(cohesion, friction_angle_deg, normal_stress):
    friction_angle_rad = np.radians(friction_angle_deg)
    return cohesion + normal_stress * np.tan(friction_angle_rad)
def rotated_shear_stress(sigma_xx, sigma_yy, sigma_xy, theta_deg):
    theta_rad = np.radians(theta_deg)
    sigma_xy_rot = 0.5 * (sigma_xx - sigma_yy) * np.sin(2 * theta_rad) + sigma_xy * np.cos(2 * theta_rad)
    return sigma_xy_rot

def plot_rotated_shear(csv_file, p, K, tensile_strength, cohesion, friction_angle_deg, angles_deg):
    if not os.path.exists(csv_file):
        print(f"Error: File {csv_file} not found.")
        return

    try:
        data = pd.read_csv(csv_file)

        r = data['x']
        sigma_xx = data['stress_xx']
        sigma_yy = data['stress_yy']
        sigma_xy = data['stress_xy']

        sigma_n = p * K
        shear_strength = mohr_coulomb_shear_strength(cohesion, friction_angle_deg, sigma_n)

        plt.figure(figsize=(10, 6))

        for angle in angles_deg:
            sigma_xy_rot = rotated_shear_stress(sigma_xx, sigma_yy, sigma_xy, angle)
            plt.plot(r, np.abs(sigma_xy_rot), label=f'|σ_xy| at {angle}°')

        plt.axhline(y=shear_strength, color='k', linestyle='--', label=f'Shear Strength = {shear_strength:.2f} Pa')

        plt.title('Rotated Shear Stress vs Shear Strength')
        plt.xlabel('Radial Distance (r)')
        plt.ylabel('Shear Stress (MPa)')
        plt.legend()
        plt.grid(True)
        plt.tight_layout()
        plt.savefig('rotated_shear_stress_kp5_siltstone.png', dpi=300)
        # print(f"Plotted rotated shear stress at angles: {angles_deg}")

    except Exception as e:
        print(f"Error processing the CSV file: {e}")

# --- Main Execution ---
if __name__ == "__main__":
    p = 1.2985e6  # Pa → convert to MPa
    K = 1
    # p /= 1e6

    tensile_strength = 4.08e6  # MPa
    cohesion = 25.075e6        # MPa
    friction_angle_deg = 38.06

    angles_deg = [0, 15, 30, 45, 60, 75, 90]  # angles to evaluate

    csv_file = "siltstone_out_line_sample_0001.csv"
    plot_rotated_shear(csv_file, p, K, tensile_strength, cohesion, friction_angle_deg, angles_deg)
