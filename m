Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578E328B61
	for <linux-modules@vger.kernel.org>; Thu, 27 Nov 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235607; cv=none; b=bPiJk6EQAOA4Hq7v5ifVsbD+RtZka0CLErlKinRmz7IwU+JY66m0TaYeWqu4QBCHOF6eAzb6PfAEcep94Hm6Vt4tWbyUHe51sNzr0mZoV3Crvic5fuMtYES/u7wO5y2RpGSejBMphxu8et443zlBc/lcZBU5mX/TWwyURYeyV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235607; c=relaxed/simple;
	bh=gkhcWTs6XHPD0GxtPxnENGuZEHtis3L8ZQA69pXlnN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8y3l5Nnlgm6bulB2vEja3tz6I00z0gjPNhcYdLLJIHs+vdRGOWELxYt3h42JHiaL983r4Avxw46KVW8Y390n8O6avCpRZ3huosf/Mg+fqjN6tux2qaRJ3dA4m0GPS2BZb0GLH7Preu7GubI2wyeRhT4XR4+VfqFYnqPC/gTyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTWraquO; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTWraquO"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee1e18fb37so7842511cf.0
        for <linux-modules@vger.kernel.org>; Thu, 27 Nov 2025 01:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235604; x=1764840404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OWEzp8zQUmQASMa9ie9YmU0L5qUiWswZqISHBOTlwSA=;
        b=JTWraquOxpL65irsXt57/TYfKUi0g01r86MIsQw+hXwcbDKaVc4Mq8n/7h1GPCClFY
         mHXXXEKWj9VIuniSD+vExU1C+Kfy80HY4S2dcQtozX3ZxAZJDItnGNjj96WCQxaZvJVC
         bLlmRLwxIdQt56NKeAHb9K5J2rX/ZTcsHxX6uSd5mrR7waD5w9k6snc3JlKQQNreY7a6
         GksOXTVRExD+cmYajvMwX4WRZ+43Ou/U7/TBWZVIP1gkyCEI2gtyKUyKmnj1wvkgnLja
         XyicuE2MBtJtvDa30JGCCTiQC/sQVDUITw5GEUtJZY7iYdirBxXkfYyG1QWTEzyyY6pO
         2I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235604; x=1764840404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWEzp8zQUmQASMa9ie9YmU0L5qUiWswZqISHBOTlwSA=;
        b=v0b2qAr7O16KT0ZWAgL20OMlVkl6HHPGsdFMTX+necHnE8QRHLVpJbBqjVLafCPSYT
         q8ZMLwwtRu2FGFEusi6uZll+Wij1ROinPmMFVbNedZwuBhUpCZ5cOmt7j3Mm99FvXGmu
         vVGJxp4/trBTlbo5VtNX8L4Pb0zkHlWyYwS7DQn7D62nKezDf0OmFZQhW0HtnJneP9EF
         6UP4A31zHC3g012JpGGzwqWDsJ25mtWL2a8al89xQebGj80NxIo/UeZohbvQBGcHrECk
         2kwJv5HGOSoP1QtbF+S3jVqRXhexoJsnC+noBt4fwNLPKfCEiXBq9nnLFqaUm9b2bqhk
         vWDg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Wx0aRyG9yZ3JlvzdZeFD03olsxXu6twohU9q0x8mGFjT157fg0/s/uxgon1+U/ctgeUuD+h3nVT7IrtC@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFg+t5zWKEnd1C/O7Do3yBbRBKZu2thk9rCbsqOm7XDcLDT0u
	vxrQjqhAmlKFrXxZFO0ef4CsJOk+2/L/dUUJSEFIshNci3/DHKlhxlG72CnWHIISHy2A+swIHT1
	2iJT/M/DldFQJhHAp9h755eZiwz0Ewin6j4/SwkuL
X-Gm-Gg: ASbGnctSP5neumJVrWIFqAzsyP+Cn8N8qYS/w/syuKZTg/NPlXG/ZcoxMTguM7NAIKz
	sGBg9iIMDneOdDHOfc1ySw7szmkWfnVc/ZQGNPdMsTE+PDgbS8IaKiTlM1rXikIQIQtAza9GxKI
	viecEwKYR4fGYq4FufUv9xLOf8L6hiwVfaJ/6SMfKU9k1Ee9S8Ccc3CBu818QtZn8tpxwUrKtW8
	VeNu5j5PfojQv5oLMyHHfq19hiyLR74aNs5i75Tk9S7gFq0YKNPwqd6/XdXlBOmdgS/YA==
X-Google-Smtp-Source: AGHT+IEkT5sCukaPzIaA+NLZWrr9JoV2OMXXL4LmCmPyzPL4gvLMcSKdyRa5hEdOBEyE9aeaeW9w9HzvquWVNQAXvGA=
X-Received: by 2002:ac8:5f06:0:b0:4ee:219e:e74 with SMTP id
 d75a77b69052e-4efbdb254demr133247771cf.77.1764235603711; Thu, 27 Nov 2025
 01:26:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202511210858.uwVivgvn-lkp@intel.com> <84b74435-5aad-4c15-aea5-db87b4a6bf11@kernel.org>
 <CANiq72mCd7FVO0Btsvct5Dy67TkBJd=QJgnPvLMn9d43Vy0YnA@mail.gmail.com>
In-Reply-To: <CANiq72mCd7FVO0Btsvct5Dy67TkBJd=QJgnPvLMn9d43Vy0YnA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 27 Nov 2025 17:26:31 +0800
X-Gm-Features: AWmQ_bkv4jFqUVeh8Qet3Ka4JTmk4vo1-CieIBCvvBE5E8ixD9z_QhWmpogPjVE
Message-ID: <CABVgOS=SFM7Po-Xyf0nyT=np8fKNJzuHSBeyw+m4dL1vivq1WA@mail.gmail.com>
Subject: Re: [linux-next:master 4806/10599] error[E0560]: struct
 `bindings::kernel_param_ops` has no field named `get`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, kernel test robot <lkp@intel.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Benno Lossin <lossin@kernel.org>, linux-modules@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007f296e0644901cc5"

--0000000000007f296e0644901cc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 21:50, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Nov 26, 2025 at 2:41=E2=80=AFPM Daniel Gomez <da.gomez@kernel.org=
> wrote:
> >
> > On 21/11/2025 01.24, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git master
> > > head:   88cbd8ac379cf5ce68b7efcfd4d1484a6871ee0b
> > > commit: 0b08fc292842a13aa496413b48c1efb83573b8c6 [4806/10599] rust: i=
ntroduce module_param module
> > > config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/a=
rchive/20251121/202511210858.uwVivgvn-lkp@intel.com/config)
> > > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-proje=
ct 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
> > > rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20251121/202511210858.uwVivgvn-lkp@intel.com/reproduce)
> >
> > We can't reproduce this.
> >
> > If anyone cares, please let us know how to reproduce it.
> >

Thanks -- this does sit in the category of things I care about (at
least in theory), but also can't reproduce.

It looks like this affects random struct fields in bindings:: (I've
seen other 0day reports with other structs and fields). If anyone has
any idea what's going on, suggestions are welcome.

Cheers,
-- David

--0000000000007f296e0644901cc5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg5LXBbVwJviFHaG7sd1NMdeLa/KMU
naVDj9iq5y+s09MwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MTI3MDkyNjQ0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAVHDyUQgDfm2klAOfnDAqPBl+Yc6L5AM49NAME17UhB6D/zvdtSrQIpeR+mHH67l7
l5WjBdX2HzuxLQ80nC8Wui4M8OzGGmRhlMUHHlW+JcyrHC6AdzsJGowzC97LpRd2QN9Zy7HZO82Q
SWrKmwdxrbt7I1t0SdJgLUM5t6gYTB2MkiQds/snyGcK9th3wKl/oxCQHdJsz/afh/YNRMGQbsXm
NOw0c/mI+XsFKWaiGdhf4l5NhGCAKJt6jv7gr0CNBkkFpuJyzMp60iLggElen+0feroJa9SOUbkZ
rq3+fDNFAVk5+1V5433w0kTN7vcWVPNT4XjpRdgdufDAy9HZSA==
--0000000000007f296e0644901cc5--
