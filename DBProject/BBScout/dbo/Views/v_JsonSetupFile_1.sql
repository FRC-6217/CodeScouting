CREATE view v_JsonSetupFile AS
select ge.loginGUID
     , dbo.fn_JsonSetupFile(ge.loginGUID) JsonFile
  from v_GameEvent ge