import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os

# Function to convert Cartesian to polar coordinates
def cartesian_to_polar(x, y, stress_xx, stress_yy, stress_xy):
    # Calculate r and theta
    r = np.sqrt(x**2 + y**2)
    theta = np.arctan2(y, x)
    
    # Transform stresses
    sigma_rr = stress_xx * np.cos(theta)**2 + stress_yy * np.sin(theta)**2 + 2 * stress_xy * np.sin(theta) * np.cos(theta)
    sigma_tt = stress_xx * np.sin(theta)**2 + stress_yy * np.cos(theta)**2 - 2 * stress_xy * np.sin(theta) * np.cos(theta)
    sigma_rt = (stress_yy - stress_xx) * np.sin(theta) * np.cos(theta) + stress_xy * (np.cos(theta)**2 - np.sin(theta)**2)
    
    return r, theta, sigma_rr, sigma_tt, sigma_rt

# Analytical solution from Kirsch equations
def kirsch_solution(r, theta, p, K, a=5.0):
    # p: far-field stress
    # K: horizontal to vertical stress ratio
    # a: tunnel radius
    
    sigma_rr = 0.5*p*(1+K)*(1-a**2/r**2) - 0.5*p*(1-K)*(1-4*a**2/r**2+3*a**4/r**4)*np.cos(2*theta)
    sigma_tt = 0.5*p*(1+K)*(1+a**2/r**2) + 0.5*p*(1-K)*(1+3*a**4/r**4)*np.cos(2*theta)
    sigma_rt = 0.5*p*(1-K)*(1+2*a**2/r**2-3*a**4/r**4)*np.sin(2*theta)
    
    return sigma_rr, sigma_tt, sigma_rt

# Read MOOSE output file
def plot_comparison(csv_file, p, K):
    # Check if file exists
    if not os.path.exists(csv_file):
        print(f"Error: File {csv_file} not found.")
        return
    
    # Read MOOSE output
    try:
        data = pd.read_csv(csv_file)
        
        # Extract x positions
        x_positions = data['x']  # or 'x' if available
        
        # Line sampler is along x-axis so y=0
        y_positions = np.zeros_like(x_positions)
        
        # Get stress components from MOOSE
        stress_xx = data['stress_xx']
        stress_yy = data['stress_yy']
        stress_xy = data['stress_xy']
        
        # Convert to polar coordinates
        r, theta, sigma_rr_moose, sigma_tt_moose, sigma_rt_moose = cartesian_to_polar(
            x_positions, y_positions, stress_xx, stress_yy, stress_xy)
        
        # Calculate analytical solution along the same points
        sigma_rr_kirsch, sigma_tt_kirsch, sigma_rt_kirsch = kirsch_solution(r, theta, p, K)
        
        # Create plots
        plt.figure(figsize=(12, 10))
        
        # Plot sigma_rr
        plt.subplot(3, 1, 1)
        plt.plot(r, sigma_rr_moose, 'bo-', label='MOOSE')
        # plt.plot(r, sigma_tt_moose, 'bo-', label='MOOSE')
        plt.plot(r, sigma_rr_kirsch, 'r-', label='Kirsch')
        plt.title('Radial Stress (σ_rr)')
        plt.xlabel('Radial distance (r)')
        plt.ylabel('Stress (Pa)')
        plt.legend()
        plt.grid(True)
        
        # Plot sigma_tt
        plt.subplot(3, 1, 2)
        plt.plot(r, sigma_tt_moose, 'bo-', label='MOOSE')
        # plt.plot(r, sigma_rr_moose, 'bo-', label='MOOSE')
        plt.plot(r, sigma_tt_kirsch, 'r-', label='Kirsch')
        plt.title('Tangential Stress (σ_θθ)')
        plt.xlabel('Radial distance (r)')
        plt.ylabel('Stress (Pa)')
        plt.legend()
        plt.grid(True)
        
        # Plot sigma_rt
        plt.subplot(3, 1, 3)
        plt.plot(r, -sigma_rt_moose, 'bo-', label='MOOSE')
        plt.plot(r, sigma_rt_kirsch, 'r-', label='Kirsch')
        plt.title('Shear Stress (σ_rθ)')
        plt.xlabel('Radial distance (r)')
        plt.ylabel('Stress (Pa)')
        plt.legend()
        plt.grid(True)
        
        plt.tight_layout()
        plt.savefig('kirsch_verification_kp25.png', dpi=300)
        # plt.show()
        
        # Calculate mean errors
        rr_error = np.mean(np.abs((sigma_rr_moose - sigma_rr_kirsch)/p)) * 100
        tt_error = np.mean(np.abs((sigma_tt_moose - sigma_tt_kirsch)/p)) * 100
        rt_error = np.mean(np.abs((sigma_rt_moose - sigma_rt_kirsch)/p)) * 100
        
        print(f"Mean relative error for σ_rr: {rr_error:.2f}%")
        print(f"Mean relative error for σ_θθ: {tt_error:.2f}%")
        print(f"Mean relative error for σ_rθ: {rt_error:.2f}%")
        
    except Exception as e:
        print(f"Error processing the CSV file: {e}")

# Main script execution
if __name__ == "__main__":
    # Parameters
    p = 1.25e6  # Far-field vertical stress (Pa)
    K = 0.25  # Horizontal-to-vertical stress ratio (K=1 for hydrostatic condition)
    
    # Path to your MOOSE output CSV file
    csv_file = "simple_f_out_line_sample_0001.csv"  # Update with your actual file name
    
    # Generate plots and error analysis
    plot_comparison(csv_file, p, K)
    
    # Additional analysis: Plot stresses at different K values
    plt.figure(figsize=(15, 12))
    
    # Generate r values for analytical plots
    r_values = np.linspace(5.0, 10.0, 100)  # From tunnel wall to far-field
    theta = 0  # Along horizontal axis (x-axis)
    
    # Plot for different K values
    K_values = [0.5, 1.0, 1.5, 2.0]
    colors = ['r', 'g', 'b', 'c']
    
    plt.subplot(3, 1, 1)
    for i, K in enumerate(K_values):
        sigma_rr, _, _ = kirsch_solution(r_values, theta, p, K)
        plt.plot(r_values, sigma_rr, color=colors[i], label=f'K={K}')
    plt.title('Radial Stress (σ_rr) at θ=0° for Different K Values')
    plt.xlabel('Radial distance (r)')
    plt.ylabel('Stress (Pa)')
    plt.legend()
    plt.grid(True)
    
    plt.subplot(3, 1, 2)
    for i, K in enumerate(K_values):
        _, sigma_tt, _ = kirsch_solution(r_values, theta, p, K)
        plt.plot(r_values, sigma_tt, color=colors[i], label=f'K={K}')
    plt.title('Tangential Stress (σ_θθ) at θ=0° for Different K Values')
    plt.xlabel('Radial distance (r)')
    plt.ylabel('Stress (Pa)')
    plt.legend()
    plt.grid(True)
    
    plt.subplot(3, 1, 3)
    for i, K in enumerate(K_values):
        _, _, sigma_rt = kirsch_solution(r_values, theta, p, K)
        plt.plot(r_values, sigma_rt, color=colors[i], label=f'K={K}')
    plt.title('Shear Stress (σ_rθ) at θ=0° for Different K Values')
    plt.xlabel('Radial distance (r)')
    plt.ylabel('Stress (Pa)')
    plt.legend()
    plt.grid(True)
    
    plt.tight_layout()
    plt.savefig('kirsch_k_comparison.png', dpi=300)
    # plt.show()