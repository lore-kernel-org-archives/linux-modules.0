Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCA139D1B;
	Sat,  6 Sep 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757174121; cv=none; b=P9ctJOsYoFpzy02hzJhsRgm+nnRFsxhxygWzRDoAFAS2J/7JSVGr92cJ/FZ8R/SudniIteMpobQnrI4qVO6I5ixL4TopoS2Uutb5GsxCyHrajFJXT1K3Sa0lLhH6416Uob5lHUjNLi3RiK3oZF9BpFYPosrO0VJjNyeE7Ra8Xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757174121; c=relaxed/simple;
	bh=pusvaT4QnUqNhVU+yqfcfBY4XHjlaraKrUBkz5GMbqg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZPEXC6tyPL6u3di4fGjMsU6kh+Yc+N4gPZ84h5ZKl9bSfmPpqXFwmA53KSfoeT709kFEhXMjNqOYv3WSfGAOoAAO74mqQYJN+O0dYKE2HFBn+OFCJX1BnIiSEMAYfYWPTJVsWblUFkyuKq1KgZ0oVaES1Po5vT3W8UiU3vmkvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QqpNP19G; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QqpNP19G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757174108; x=1757778908; i=markus.elfring@web.de;
	bh=OExIo3lRBS9A0say9BJwiBOH0gdAkPVvGA4CL/eJVHw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QqpNP19GFMaA5SeAxWo8nNXGolhOTubTDdYDNzVg84VcM1jnTPEqJsMAihMXmFpM
	 ZD6Mj8eOjh6E2RzmyquQUc2AC1m/dBbENhZKRQXpAxJzNt3WZV5YhZiPnLWvFOTIm
	 MBEwUwPcpiUvbo42UQE9Poi+el24rUKyeLJsjbFKecMhplhccJtI6U/f2mT0hHiCS
	 HwZcbUF09scZw/fLAYzNp4QluaTe+E5FMCevjDFq7CcZ0mkFCrc0SiYHKGWgmeAeh
	 yEL0+uPU2cnKbXSIQTWlnUmIv1Fa77jRB/Z+JlAy8E6dywY7brj105JgMmhkPGwEq
	 lAowedZoNjmaI8Czzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUU6E-1v3ggF3uZU-00S4Uv; Sat, 06
 Sep 2025 17:55:07 +0200
Message-ID: <08543dfc-85e3-4f21-bf30-de612a47504e@web.de>
Date: Sat, 6 Sep 2025 17:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Fidal palamparambil <rootuserhere@gmail.com>,
 linux-modules@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>
References: <20250906131559.200-1-rootuserhere@gmail.com>
Subject: Re: [PATCH] kprobe_event_gen_test : Fix error handling and resource
 cleanup
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250906131559.200-1-rootuserhere@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PaGBkMOBmCChbifVnWm+1zPmg4z/+1YJnH6Fp2XBPYenQ+pTemC
 /8qrzVNmrIbwnuSO/YE+aph3/docgwDx0tWFKC7svfQfwDQcyi6v8v+S36q7kWDL/FMrTHs
 /dk3t9jEsUV3AxNknVotudKTqo6Jfl3mwqwOr5xW5NQoK7dK7LnNMVJxpfooXtP1ah7NH/P
 6Zv8QSc0Y10ano2o6g8bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hFr4JUcTzfo=;zaan9W8smddar4Z71UWYpai/HZn
 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

> This commit addresses several issues =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc4#n94


=E2=80=A6
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -129,6 +129,7 @@ static int __init test_gen_kprobe_cmd(void)
>  					       "gen_kprobe_test");
>  	if (IS_ERR(gen_kprobe_test)) {
>  		ret =3D PTR_ERR(gen_kprobe_test);
> +		gen_kprobe_test =3D NULL;

May the repetition be reduced for this assignment statement?


>  		goto delete;

How do you think about to use an additional label?


>  	}
=E2=80=A6

Regards,
Markus
