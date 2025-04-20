s0 = -2.7e6#depth of center of tunnel 50m
K = 0.5

[Mesh]
  file = one35.msh
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Physics/SolidMechanics/QuasiStatic]
  [all]
    strain = SMALL
    generate_output = 'vonmises_stress stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz'
    add_variables = true
    block = 'top_rock bottom_rock'
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
      expression = K*s0
    []
    [-sigma_h]
        type = ParsedFunction
        symbol_names = 'K s0'
        symbol_values = '${K} ${s0}'
        expression = -K*s0
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
  [fix_mt_mb_disp_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'mt mb'
    value = 0 
  []
  [fix_ml_mr_disp_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'ml mr'
    value = 0 
  []
[]

[Materials]
  [elasticity]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 52e9 #young's modulus of Granite
    poissons_ratio = 0.25 
    block = 'top_rock bottom_rock'
  []
  [stress]
    type = ComputeLinearElasticStress 
    block = 'top_rock bottom_rock'
  []
  [strain_from_initial_stress]
    type = ComputeEigenstrainFromInitialStress
    initial_stress = ' -sigma_h 0 0 0 -${s0} 0 0 0 -sigma_h'
    eigenstrain_name = ini_stress
    block = 'top_rock bottom_rock'
  []
[]

[Contact]
    [fault_contact]
      secondary = 'top_fault'
      primary = 'bottom_fault'
      model = coulomb  
      friction_coefficient = 0.3
      formulation = penalty
      penalty = 8e9
      normalize_penalty = true
      tangential_tolerance = 0.005
    []
[]

[Preconditioning]
  [SMP]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Steady 
  solve_type = NEWTON 
  line_search = 'none'
  automatic_scaling = true
  nl_abs_tol = 1e-4
  nl_rel_tol = 1e-4
  l_abs_tol = 1e-50
  l_tol = 1e-5
  l_max_its = 400
 []

[VectorPostprocessors]
  [data]
    type = LineValueSampler
    warn_discontinuous_face_values = false
    start_point = '5.2 0 0'
    end_point = '49.5 0 0'
    num_points = 100
    sort_by = x
    variable = 'disp_x disp_y stress_xx stress_yy stress_xy'
    execute_on = TIMESTEP_END
  []
[]

[Outputs]
  exodus = true
  csv = true
[]
