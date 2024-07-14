Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F215C0;
	Sun, 14 Jul 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720957919; cv=none; b=o4GGJWqYPVvOG9oyYjXHLestTT3kJ3L6W0ZndVyc+mQ44ne5unL2di0/3iItN2kzkfFWHHnRBAfrs8oDIHuLMp+/4nAoqcvCsV29icnVluCaEWALkbNr9VU4VdVi+BzNbHWaerLs8iinasvuWblQoJVbVgAoV13OiPPZqequVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720957919; c=relaxed/simple;
	bh=mnvBJJl2oILdBmJUSwBnl9m1Qsxmr+kYSIcSPT5WHxU=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=ZYdpru820KPSEyz75s/43PjpbFJakVgCLYBdSstsHscAFnlYXsaGOHCFekVyQXPzCBIGmRQh7VClJNlcHojKwL0LB+UJEjozHLEm8gdnC7wXlSsrmJH3/+BVgt0Xq+LtSWXKhcssD4yEk2ivZp4+YT4Z9EulpfCKl+FdzTwS8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Tk2fyNDW; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Tk2fyNDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720957910; x=1721562710; i=markus.elfring@web.de;
	bh=nDAhleMulhqKEzdv+vsErFaaUrjnXZiCoSZYFMrFO1Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Cc:From:Subject:
	 To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tk2fyNDWONq+xt/WevHyxSlM0KKUJ+Ppp+FgnazhJoe99qdMpjwzR0lt2zQam9g4
	 wh8ikDMi/BfSPX8JoSQIumm4WATtjX/LNji4cadtlhf2UALGTXndqGnbr3oBx0fUP
	 A/INzvpUMIveVSvIQaxK1t/CKI6F2Ah/qt2YD3USW/EVAAWmcTUo9Ma6dRKm+Xcs3
	 0/KEDJu8yL5pXNDqlHWSYpSvE4jlJP4FwIXbzZhRX0xKr74BHFTbsKOzNrzbmEQTn
	 nL+6b7fxxJtP1hfOKIOn87g85IEIhD72mE+vMB5xDHK/T4THFKJyobeZd+QnoubNY
	 cHpFfweNZ9hiIwusTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtgyp-1sDlIf07FH-00tUeV; Sun, 14
 Jul 2024 13:51:50 +0200
Message-ID: <a44f2ae6-0242-40a3-bdfc-b81fe862eec9@web.de>
Date: Sun, 14 Jul 2024 13:51:49 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] module: tracking: Extend format string of a seq_printf() call
 in unloaded_tainted_modules_seq_show()
To: linux-modules@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:baZG2ulOL/demBIBwplDbo5i7K6cjtdXWKG2tOGJcEqd8Avh01L
 QeJ2n17Nfk61Zu0njsW1vRlfAzV5hRW3zV/W1liNy+520VlaQAgqNqIGutTUWACh8rp9Yfq
 QtJXnHLFnSeziozTufzVelukj4BoyVoC0gomPd1C4swOVj46Cx/oSI9HSCQvCv26S82p8NG
 i9pHqaRq3PwDSskLB3LOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TbNRlhVQwjY=;97OViBGYNY0cBMJuxnWdywbqZ+u
 CW+e4JWXHw0Ix6ePGCAX1Z/2CeNuTYMtoO4asD/VCnrwrUoQeepl7oYQFCenpZzZXcz22Nbnr
 fiy4xPJok1Ez3FGWYqphNNMAaNHySQ4nUWmBw6Juj+1NexGT5zPjRd1+ARdv23g6OvLGneQiy
 RPsSiIxy5esJhP3mM3wFIJR0oBojwPdPYcjESLzJLECW/9UdME8w5K5S0Cw0JO1ZPuoI2bZhf
 iWEUsKAPAfmGVftnSDiaAZ2kzHm3G4Khd2Y+kpK8IpA/+Vpiu1V2aBvkabPa3P6nuSDhQLr5P
 eTuIMzEhyuVM1Zl/fR0NEBUy7YBPL/P8Zk8uI3onFypgeRQKmgv3E3m1KjukUe7fi6jxXm91F
 m6LYQkJwjI7HDpE76WjNNQ7o1ajxWEFet9d9TQfc9i30gJXxJtnQo8r83hLT0+vncdj6swj+G
 i4bH6+IpIW1K18CdTkvmLW4UDlZXhU4J0GfSQDtcE6dfVPKS7yLvkUoCDWYXjyKasrKufs6Q4
 T6m8sjkFtMd8k9IYz0WAnchwyajHqSp5XdcZQeR3fbOLhscbCCF/aFl30vOy9o0jxqMHaJQtc
 cPKpBXHSa6tCiR+Tma+Ax4gaBhuCTB+9RSFym2dGBIrMDsqyPAGE2WoAVMHWruqMWujjbw98c
 IFwszc105k0voOTV7UlfDltau90+dg6HEDPViOF3cBHVlmqaS2xlmvJF6W8Dso+IMrSGZwZtO
 hnj4L1MiIc/FBaMCnE91yA+8gwplnE9QSdJ9y9KlipFkEjgOT+hb9c6rhisbgS11nNjoxrgqr
 LSQ143f6OmxGVr3tjLjBSvqA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 13:43:06 +0200
Subject: [PATCH] module: tracking: Extend format string of a seq_printf() =
call in unloaded_tainted_modules_seq_show()

* Move the specification of a single line break from a seq_puts() call
  into the format string of a previous seq_printf() call.

* Omit an extra call of the function =E2=80=9Cseq_puts=E2=80=9D
  because of this refactoring.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/module/tracking.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 16742d1c630c..9f84271c23b3 100644
=2D-- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -94,9 +94,7 @@ static int unloaded_tainted_modules_seq_show(struct seq_=
file *m, void *p)
 	l =3D module_flags_taint(mod_taint->taints, buf);
 	buf[l++] =3D '\0';

-	seq_printf(m, "%s (%s) %llu", mod_taint->name, buf, mod_taint->count);
-	seq_puts(m, "\n");
-
+	seq_printf(m, "%s (%s) %llu\n", mod_taint->name, buf, mod_taint->count);
 	return 0;
 }

=2D-
2.45.2

