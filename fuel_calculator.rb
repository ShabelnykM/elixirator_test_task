# frozen_string_literal: true

class FuelCalculator
  attr_reader :program, :mass, :fuel

  ERROR_RESPONCE = <<-TEXT
    Please provide valid input in format: ['mass as number',[[:lounch or :land, 'gravity as number'], ...etc]
    Example: FuelCalculator.new(28_801,[[:launch, 9.807],[:land, 9.807]]
  TEXT

  def initialize(mass, program)
    @mass = mass.to_i
    @program = program
    @fuel = 0
  end

  def call
    program.reverse.each do |stage, gravity|
      calculate_fuel_for_stage(stage, gravity)
    end
    fuel
  rescue StandardError
    ERROR_RESPONCE
  end

  private

  def calculate_fuel_for_stage(stage, gravity)
    additional_mass = mass + fuel
    stage_fuel = 0
    while additional_mass.positive?
      additional_mass = send(stage, additional_mass, gravity)
      break if additional_mass.negative?

      stage_fuel += additional_mass
    end
    @fuel += stage_fuel
  end

  def launch(mass, gravity)
    ((mass * gravity * 0.042) - 33).floor
  end

  def land(mass, gravity)
    ((mass * gravity * 0.033) - 42).floor
  end
end
