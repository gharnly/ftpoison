defmodule FTPoisonTest do
  use ExUnit.Case
  doctest FTPoison

  test """
  start/1
  given valid host string
  will start an ftp connection
  """ do
    pid = FTPoison.start("localhost")
    refute is_nil(pid)
  end

  test """
  start/1
  given invalid host
  will respond with appropriate error
  """ do
    assert_raise FTPoison.Error,
                 "Host is not found, FTP server is not found, or connection is rejected by FTP server.",
                 fn ->
                   FTPoison.start("notaserver")
                 end
  end

  test """
  start/1
  given valid host
  and ftp is already started
  does not fail to start server
  """ do
    :ftp.start()
    pid = FTPoison.start("localhost")
    refute is_nil(pid)
  end

  test """
  pwd/1
  given active FTP PID
  returns current working directory as a String
  """ do
    pid = FTPoison.start("localhost")

    assert_raise FTPoison.Error, " Please login with USER and PASS.\r\n", fn ->
      FTPoison.pwd(pid) == "/"
    end
  end

  test """
  list/1
  given active FTP PID
  returns the listing as a String
  """ do
    pid = FTPoison.start("localhost")

    assert_raise FTPoison.Error, " Please login with USER and PASS.\r\n", fn ->
      FTPoison.list(pid) == []
    end
  end
end
