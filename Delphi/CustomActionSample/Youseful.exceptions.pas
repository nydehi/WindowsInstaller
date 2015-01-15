unit Youseful.exceptions;
(*----------------------------------------------------------------------------
 *  This program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)1999-2005 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)
 
{I ysfl_CondDefine.inc}

interface

uses
  SysUtils;

type
  EAI = class(Exception);

  EAIUserAbort = class(EAI)
  public
    constructor Create;
  end;

  EUserAbortInstall = class(Exception);

  EYousefulException = class(Exception);

  ECustomYousefulAbnormal = class(Exception);

  EYousefulAbnormal = class(ECustomYousefulAbnormal);

  { TYsflCompress }
  EYsflCompress = class(EYousefulAbnormal);
  EycDiskFull = class(EYsflCompress);
  EycAborted = class(EYsflCompress);

  { routines_API }
  EAPIRoutines = class(EYousefulAbnormal);

  { TProgramLauncher }
  EProgramLauncher = class(EYousefulAbnormal);

  EProgramLauncherFailed = class(EProgramLauncher)
    ErrorCode: Integer;
  end;

  EProgramLauncherTimeout = class(EProgramLauncher);

  { TYsflTCPIP }

  EYsflSocket = class(EYousefulAbnormal)
    ErrorNumber: Word;
    constructor Create(Number: Word);
  end;

  EYsflSocketLogin = class(EYsflSocket);

  { TYsflFTP }
  EYsflFTP = class(EYousefulAbnormal);

  EYsflFTPLogin = class(EYsflFTP);

  EYsflFTPLogin_Password = class(EYsflFTP);
  EYsflFTPLogin_UserName = class(EYsflFTP);
  EYsflFTPLogin_HostName = class(EYsflFTPLogin);

  EYsflFTPBusy = class(EYsflFTP);

  EYsflFTPCode = class(EYousefulAbnormal)
    ErrorNumber: Word;
    constructor Create(const Msg: String;Number: Word);
  end;

  { ENetSetupOCXInformation }
  ENetSetupOCXInformation = class(EYousefulAbnormal);

 
  
implementation

constructor EAIUserAbort.Create;
begin
  Self.Message := 'Installation aborted by the user';
end;

constructor EYsflFTPCode.Create(const Msg:String;Number: Word);
begin
  inherited Create(Msg);
  ErrorNumber := Number;
end;

constructor EYsflSocket.Create(Number: Word);
begin
  inherited Create('Error creating socket');
  ErrorNumber := Number;
end;



end.
