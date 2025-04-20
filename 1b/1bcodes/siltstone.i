s0 = -2.597e6 #gamma*g*h #h=50m #gamma = 2700 (given) #g =10
K = 0.5 #the ratio of horizontal and vertical stress #sigma_h/sigma_v

[Mesh]
  type = FileMesh
  file = tunnel_refined.msh
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Variables]
  [disp_x]
    order = FIRST
    family = LAGRANGE
  []
  [disp_y]
    order = FIRST
    family = LAGRANGE
  []
[]

[Physics/SolidMechanics/QuasiStatic]
  [all]
    strain = SMALL
    generate_output = 'vonmises_stress stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz'
    add_variables = true
    block = 'domain'
    material_output_family = 'MONOMIAL'
    material_output_order = 'FIRST'
    eigenstrain_names = ini_stress 
  []
[]

[Functions]
  [sigma_h]
    type = ParsedFunction
    symbol_names = 'K s0'
    symbol_values = '${K} ${s0}'
    expression = K*s0 #k*s0
  []
  [-sigma_h]
    type = ParsedFunction
    symbol_names = 'K s0'
    symbol_values = '${K} ${s0}'
    expression = -K*s0
  []
[]

[Materials]
  [elasticity]
    type = ComputeIsotropicElasticityTensor
    block = domain
    youngs_modulus = 23.3e9 #young's modulus of Granite
    poissons_ratio = 0.198
  []
  [ini_stress]
    type = ComputeEigenstrainFromInitialStress
    block = domain
    initial_stress = 'sigma_h ${s0} 0 0 sigma_h 0 0 0 0'
    # For 2D plane strain: [sigma_xx sigma_yy sigma_zz sigma_xy sigma_xz sigma_yz]
    # Here, sigma_xx = K*s0 (horizontal), sigma_yy = s0 (vertical), sigma_zz = 0
    eigenstrain_name = ini_stress
  []
  [stress]
    type = ComputeLinearElasticStress
  []
[]

[BCs]
  [vertical_stress]
    type = Pressure
    variable = disp_y
    boundary = 'top bottom'
    factor = ${s0} 
  []  
  [horizontal_stress]
    type = Pressure
    variable = disp_x
    boundary = 'left right'
    function = sigma_h
  []
[]

[VectorPostprocessors]
  [line_sample]
    type = LineValueSampler
    warn_discontinuous_face_values = false
    start_point = '5.2 0 0'  # just outside the tunnel wall
    end_point = '49.5 0 0'
    num_points = 10000
    sort_by = x
    variable = 'disp_x disp_y stress_xx stress_yy stress_xy'
    execute_on = TIMESTEP_END
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
[]

[Outputs]
  exodus = true
  csv = true
[]
