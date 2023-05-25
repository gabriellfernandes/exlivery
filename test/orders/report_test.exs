defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "when valid parameters return string" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      expected_response =
        "123456789,pizza,24.5,2,pizza,24.5,2,98.00\n" <>
          "123456789,pizza,24.5,2,pizza,24.5,2,98.00\n"

      assert response == expected_response
    end
  end
end
