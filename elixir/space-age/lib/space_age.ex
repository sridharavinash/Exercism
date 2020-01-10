defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @earth_year_in_seconds 31_557_600.0
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    case planet do
      :earth ->
        seconds / @earth_year_in_seconds

      :mercury ->
        seconds / (@earth_year_in_seconds * 0.2408467)

      :venus ->
        seconds / (@earth_year_in_seconds * 0.61519726)

      :mars ->
        seconds / (@earth_year_in_seconds * 1.8808158)

      :jupiter ->
        seconds / (@earth_year_in_seconds * 11.862615)

      :saturn ->
        seconds / (@earth_year_in_seconds * 29.447498)

      :uranus ->
        seconds / (@earth_year_in_seconds * 84.016846)

      :neptune ->
        seconds / (@earth_year_in_seconds * 164.79132)
    end
  end
end
