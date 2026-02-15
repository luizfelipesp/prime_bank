Mox.defmock(PrimeBank.ViaCep.ClientMock, for: PrimeBank.ViaCep.Behaviour)
Application.put_env(:prime_bank, :via_cep_client, PrimeBank.ViaCep.ClientMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(PrimeBank.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)
