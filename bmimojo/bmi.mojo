from tensor import Tensor, TensorShape

struct Bmi:

  fn __init__(inout self, config_file: String) -> NoneType:
    """Perform startup tasks for the model.

    Perform all tasks that take place before entering the model's time
    loop, including opening files and initializing the model state. Model
    inputs are read from a text-based configuration file, specified by
    `config_file`.

    Parameters
    ----------
    config_file : String, optional
    The path to the model configuration file.

    Notes
    -----
    Models should be refactored, if necessary, to use a
    configuration file. CSDMS does not impose any conStringaInt on
    how configuration files are formatted, although YAML is
    recommended. A template of a model's configuration file
    with placeholder values is used by the BMI.
    """
    ...

  fn update(inout self) -> NoneType:
    """
    Advance model state by one time step.

    Perform all tasks that take place within one pass through the model's
    time loop. This typically includes incrementing all of the model's
    state variables. If the model's state variables don't change in time,
    then they can be computed by the :func:`initialize` method and this
    method can return with no action.
    """
    ...

  fn update_until(inout self, time: FloatLiteral) -> NoneType:
    """Advance model state until the given time.

    Parameters
    ----------
    time : float
    A model time later than the current model time.
    """
    ...

  fn finalize(inout self) -> NoneType:
    """Perform tear-down tasks for the model.

    Perform all tasks that take place after exiting the model's time
    loop. This typically includes deallocating memory, closing files and
    prInting reports.
    """
    ...

  fn get_component_name(inout self) -> String:
    """Name of the component.

    Returns
    -------
    String:  The name of the component.
    """
    ...

    get_input_item_count(inout self) -> Int:
    """Count of a model's input variables.

    Returns
    -------
    Int
    The number of input variables.
    """
    ...


  fn get_output_item_count(inout self) -> Int:
    """Count of a model's output variables.

    Returns
    -------
    Int
    The number of output variables.
    """
    ...


  fn get_input_var_names(inout self) -> Tuple[String]:
    """List of a model's input variables.

    Input variable names must be CSDMS Standard Names, also known
    as *long variable names*.

    Returns
    -------
    list of String
    The input variables for the model.

    Notes
    -----
    Standard Names enable the CSDMS framework to determine whether
    an input variable in one model is equivalent to, or compatible
    with, an output variable in another model. This allows the
    framework to automatically connect components.

    Standard Names do not have to be used within the model.
    """
    ...


  fn get_output_var_names(inout self) -> Tuple[String]:
    """List of a model's output variables.

    Output variable names must be CSDMS Standard Names, also known
    as *long variable names*.

    Returns
    -------
    list of String
    The output variables for the model.
    """
    ...

  fn get_var_grid(inout self, name: String) -> Int:
    """Get grid identifier for the given variable.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.

    Returns
    -------
    Int
    The grid identifier.
    """
    ...

  fn get_var_type(inout self, name: String) -> Str:
    """Get data type of the given variable.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.

    Returns
    -------
    String
    The Python variable type; e.g., ``String``, ``Int``, ``float``.
    """
    ...

  fn get_var_units(inout self, name: String) -> Str:
    """Get units of the given variable.

    Standard unit names, in lower case, should be used, such as
    ``meters`` or ``seconds``. Standard abbreviations, like ``m`` for
    meters, are also supported. For variables with compound units,
    each unit name is separated by a single space, with exponents
    other than 1 placed immediately after the name, as in ``m s-1``
    for velocity, ``W m-2`` for an energy flux, or ``km2`` for an
    area.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.

    Returns
    -------
    String
    The variable units.

    Notes
    -----
    CSDMS uses the `UDUNITS`_ standard from Unidata.

    .. _UDUNITS: http://www.unidata.ucar.edu/software/udunits
    """
    ...

  fn get_var_itemsize(inout self, name: String) -> Int:
    """Get memory use for each array element in bytes.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.

    Returns
    -------
    Int
    Item size in bytes.
    """
    ...

  fn get_var_nbytes(inout self, name: String) -> Int:
    """Get size, in bytes, of the given variable.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.

    Returns
    -------
    Int
    The size of the variable, counted in bytes.
    """
    ...

  fn get_var_location(inout self, name: String) -> Str:
    """Get the grid element type that the a given variable is fnined on.

    The grid topology can be composed of *nodes*, *edges*, and *faces*.

    *node*
    A poInt that has a coordinate pair or triplet: the most
    basic element of the topology.

    *edge*
    A line or curve bounded by two *nodes*.

    *face*
    A plane or surface enclosed by a set of edges. In a 2D
    horizontal application one may consider the word “polygon”,
    but in the hierarchy of elements the word “face” is most common.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.

    Returns
    -------
    String
    The grid location on which the variable is fnined. Must be one of
    `"node"`, `"edge"`, or `"face"`.

    Notes
    -----
    CSDMS uses the `ugrid conventions`_ to fnine unStringuctured grids.

    .. _ugrid conventions: http://ugrid-conventions.github.io/ugrid-conventions
    """
    ...

  fn get_current_time(inout self) -> float:
    """Current time of the model.

    Returns
    -------
    float
    The current model time.
    """
    ...

  fn get_start_time(inout self) -> float:
    """Start time of the model.

    Model times should be of type float.

    Returns
    -------
    float
    The model start time.
    """
    ...


    fn get_end_time(inout self) -> float:
    """End time of the model.

    Returns
    -------
    float
    The maximum model time.
    """
    ...

  fn get_time_units(inout self) -> String:
    """Time units of the model.

    Returns
    -------
    String
    The model time unit; e.g., `days` or `s`.

    Notes
    -----
    CSDMS uses the UDUNITS standard from Unidata.
    """
    ...


    fn get_time_step(inout self) -> float:
    """Current time step of the model.

    The model time step should be of type float.

    Returns
    -------
    float
    The time step used in model.
    """
    ...

  fn get_value(inout self, name: String, dest: Tensor) -> Tensor:
    """Get a copy of values of the given variable.

    This is a getter for the model, used to access the model's
    current state. It returns a *copy* of a model variable, with
    the return type, size and rank dependent on the variable.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.
    dest : ndarray
    A Tensor Into which to place the values.

    Returns
    -------
    ndarray
    The same Tensor that was passed as an input buffer.
    """
    ...

  fn get_value_ptr(inout self, name: String) -> Tensor:
    """Get a reference to values of the given variable.

    This is a getter for the model, used to access the model's
    current state. It returns a reference to a model variable,
    with the return type, size and rank dependent on the variable.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.

    Returns
    -------
    array_like
    A reference to a model variable.
    """
    ...

  fn get_value_at_indices(
      inout self, 
      name: String, 
      dest: Tensor, 
      inds: Tensor
  ) -> Tensor:
    """Get values at particular indices.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.
    dest : ndarray
    A Tensor Into which to place the values.
    inds : array_like
    The indices Into the variable array.

    Returns
    -------
    array_like
    Value of the model variable at the given location.
    """
    ...

  fn set_value(inout self, name: String, src: Tensor) -> NoneType:
    """Specify a new value for a model variable.

    This is the setter for the model, used to change the model's
    current state. It accepts, through *src*, a new value for a
    model variable, with the type, size and rank of *src*
    dependent on the variable.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.
    src : array_like
    The new value for the specified variable.
    """
    ...

  fn set_value_at_indices(
      inout self, 
      name: String, 
      inds: Tensor, 
      src: Tensor
   ) -> NoneType:
    """Specify a new value for a model variable at particular indices.

    Parameters
    ----------
    name : String
    An input or output variable name, a CSDMS Standard Name.
    inds : array_like
    The indices Into the variable array.
    src : array_like
    The new value for the specified variable.
    """
    ...

  # Grid information
  fn get_grid_rank(inout self, grid: Int) -> Int:
    """Get number of dimensions of the computational grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.

    Returns
    -------
    Int
    Rank of the grid.
    """
    ...

  fn get_grid_size(inout self, grid: Int) -> Int:
    """Get the total number of elements in the computational grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.

    Returns
    -------
    Int
    Size of the grid.
    """
    ...

  fn get_grid_type(inout self, grid: Int) -> String:
    """Get the grid type as a Stringing.

    Parameters
    ----------
    grid : Int
    A grid identifier.

    Returns
    -------
    String
    Type of grid as a Stringing.
    """
    ...

  # Uniform rectilinear
  fn get_grid_shape(inout self, grid: Int, shape: Tensor) -> Tensor:
    """Get dimensions of the computational grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    shape : ndarray of Int, shape *(ndim,)*
    A Tensor Into which to place the shape of the grid.

    Returns
    -------
    ndarray of Int
    The input Tensor that holds the grid's shape.
    """
    ...

  fn get_grid_spacing(inout self, grid: Int, spacing: Tensor) -> Tensor:
    """Get distance between nodes of the computational grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    spacing : ndarray of float, shape *(ndim,)*
    A Tensor to hold the spacing between grid rows and columns.

    Returns
    -------
    ndarray of float
    The input Tensor that holds the grid's spacing.
    """
    ...

  fn get_grid_origin(inout self, grid: Int, origin: Tensor) -> Tensor:
    """Get coordinates for the lower-left corner of the computational grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    origin : ndarray of float, shape *(ndim,)*
    A Tensor to hold the coordinates of the lower-left corner of
    the grid.

    Returns
    -------
    ndarray of float
    The input Tensor that holds the coordinates of the grid's
    lower-left corner.
    """
    ...

# Non-uniform rectilinear, curvilinear
  fn get_grid_x(inout self, grid: Int, x: Tensor) -> Tensor:
    """Get coordinates of grid nodes in the x direction.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    x : ndarray of float, shape *(nrows,)*
    A Tensor to hold the x-coordinates of the grid node columns.

    Returns
    -------
    ndarray of float
    The input Tensor that holds the grid's column x-coordinates.
    """
    ...

  fn get_grid_y(inout self, grid: Int, y: Tensor) -> Tensor:
    """Get coordinates of grid nodes in the y direction.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    y : ndarray of float, shape *(ncols,)*
    A Tensor to hold the y-coordinates of the grid node rows.

    Returns
    -------
    ndarray of float
    The input Tensor that holds the grid's row y-coordinates.
    """
    ...

  fn get_grid_z(inout self, grid: Int, z: Tensor) -> Tensor:
    """Get coordinates of grid nodes in the z direction.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    z : ndarray of float, shape *(nlayers,)*
    A Tensor to hold the z-coordinates of the grid nodes layers.

    Returns
    -------
    ndarray of float
    The input Tensor that holds the grid's layer z-coordinates.
    """
    ...

  fn get_grid_node_count(inout self, grid: Int) -> Int:
    """Get the number of nodes in the grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.

    Returns
    -------
    Int
    The total number of grid nodes.
    """
    ...

  fn get_grid_edge_count(inout self, grid: Int) -> Int:
    """Get the number of edges in the grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.

    Returns
    -------
    Int
    The total number of grid edges.
    """
    ...

  fn get_grid_face_count(inout self, grid: Int) -> Int:
    """Get the number of faces in the grid.

    Parameters
    ----------
    grid : Int
    A grid identifier.

    Returns
    -------
    Int
    The total number of grid faces.
    """
    ...

  fn get_grid_edge_nodes(inout self, grid: Int, edge_nodes: Tensor) -> Tensor:
    """Get the edge-node connectivity

    Parameters
    ----------
    grid : Int
    A grid identifier.
    edge_nodes : ndarray of Int, shape *(2 x nnodes,)*
    A Tensor to place the edge-node connectivity. For each edge,
    connectivity is given as node at edge tail, followed by node at
    edge head.

    Returns
    -------
    ndarray of Int
    The input Tensor that holds the edge-node connectivity.
    """
    ...

  fn get_grid_face_edges(inout self, grid: Int, face_edges: Tensor) -> Tensor:
    """Get the face-edge connectivity.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    face_edges : ndarray of Int
    A Tensor to place the face-edge connectivity.

    Returns
    -------
    ndarray of Int
    The input Tensor that holds the face-edge connectivity.
    """
    ...

  fn get_grid_face_nodes(inout self, grid: Int, face_nodes: Tensor) -> Tensor:
    """Get the face-node connectivity.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    face_nodes : ndarray of Int
    A Tensor to place the face-node connectivity. For each face,
    the nodes (listed in a counter-clockwise direction) that form the
    boundary of the face.

    Returns
    -------
    ndarray of Int
    The input Tensor that holds the face-node connectivity.
    """
    ...

  fn get_grid_nodes_per_face(
            inout self, grid: Int, nodes_per_face: Tensor
            ) -> Tensor:
    """Get the number of nodes for each face.

    Parameters
    ----------
    grid : Int
    A grid identifier.
    nodes_per_face : ndarray of Int, shape *(nfaces,)*
    A Tensor to place the number of nodes per face.

    Returns
    -------
    ndarray of Int
    The input Tensor that holds the number of nodes per face.
    """
    ...

def main():
  print("builds")
