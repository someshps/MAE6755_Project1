import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os

def mohr_coulomb_shear_strength(cohesion, friction_angle_deg, normal_stress):
    friction_angle_rad = np.radians(friction_angle_deg)
    return cohesion + normal_stress * np.tan(friction_angle_rad)

def plot_comparison(csv_file, p, K, tensile_strength, cohesion, friction_angle_deg):
    if not os.path.exists(csv_file):
        print(f"Error: File {csv_file} not found.")
        return

    try:
        data = pd.read_csv(csv_file)

        # Extract x positions
        x_positions = data['x']
        r = x_positions  # assuming radial line sampler
        
        # Get stress components
        sigma_xx = data['stress_xx']
        sigma_yy = data['stress_yy']
        sigma_xy = data['stress_xy']

        # Normal stress for Mohr-Coulomb
        sigma_n = p * K

        # Calculate shear strength
        shear_strength = mohr_coulomb_shear_strength(cohesion, friction_angle_deg, sigma_n)

        # Plot σ_xx vs tensile strength
        plt.figure(figsize=(12, 10))
        plt.subplot(3, 1, 1)
        plt.plot(r, sigma_xx, 'b.-', label='σ_xx (MOOSE)')
        plt.axhline(y=tensile_strength, color='r', linestyle='--', label=f'Tensile Strength ({tensile_strength:.2f} Pa)')
        plt.title('σ_xx vs Tensile Strength')
        plt.xlabel('Radial distance (r)')
        plt.ylabel('Stress (MPa)')
        plt.legend()
        plt.grid(True)

        # Plot σ_yy vs tensile strength
        plt.subplot(3, 1, 2)
        plt.plot(r, sigma_yy, 'b.-', label='σ_yy (MOOSE)')
        plt.axhline(y=tensile_strength, color='r', linestyle='--', label=f'Tensile Strength ({tensile_strength:.2f} Pa)')
        plt.title('σ_yy vs Tensile Strength')
        plt.xlabel('Radial distance (r)')
        plt.ylabel('Stress (MPa)')
        plt.legend()
        plt.grid(True)

        # Plot σ_xy vs shear strength
        plt.subplot(3, 1, 3)
        plt.plot(r, np.abs(sigma_xy), 'b.-', label='|σ_xy| (MOOSE)')
        plt.axhline(y=shear_strength, color='g', linestyle='--', label=f'Shear Strength ({shear_strength:.2f} Pa)')
        plt.title('σ_xy vs Shear Strength')
        plt.xlabel('Radial distance (r)')
        plt.ylabel('Shear Stress (MPa)')
        plt.legend()
        plt.grid(True)

        plt.tight_layout()
        # print("hello")
        plt.savefig('otf_fault_tensile_d200_k1p5.png', dpi=300)
        # print(f"Shear strength used {shear_strength:.2f} MPa at σ_n = {sigma_n:.2f} Pa")

    except Exception as e:
        print(f"Error processing the CSV file: {e}")

# Main script execution
if __name__ == "__main__":
    # Stress conditions
    p = 5.4e6  # Pa → convert to MPa
    K = 1.5
    # p /= 1e6

    tensile_strength = 5.27e6  # MPa
    cohesion = 27e6        # MPa
    friction_angle_deg = 55  # degrees

    # Convert Pa to MPa for plotting consistency
    # p /= 1e6

    csv_file = "otf_fault_out_data_0001_d200_k1p5.csv"

    plot_comparison(csv_file, p, K, tensile_strength, cohesion, friction_angle_deg)
