defmodule Percolation.CellSupervisor do
  use Supervisor

  def add_cell(ref, percolator, row_index, cell_index, cell_content) do
    Supervisor.start_child(name(ref), [ref, percolator, row_index, cell_index, cell_content])
  end

  def start_link(ref) do
    Supervisor.start_link(__MODULE__, [], name: {:local, name(ref)})
  end

  def init([]) do
    children = [
      worker(Percolation.Cell, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

  defp name(ref), do: :"percolation_cell_supervisor_#{inspect ref}"
end
