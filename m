Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EDB3E51FE
	for <linux-modules@vger.kernel.org>; Tue,  9 Jun 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999635; cv=none; b=pqH11biw0TXuWrGKvC1FcQBp6C4qYF/nwOqoGqknAK+KzOwghDZGP4a2mhsLyc4fxAm7PXzVk106Tp7VeH5KR1yncmNKEu3Z0wnwKun3UrkGPu3PNqcb7N6jthUsMlgg58vj4HcGtdFnxYqeZB3VCOA1pmj1IsgWbTz4xSbOtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999635; c=relaxed/simple;
	bh=4C8PgQ9FE9L7n6/Z7yWqH9fic/Jpg5Q4xG+oktm/EO8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=dFKYAbaUUD7jOCGuQbCxqOcJj+tJ1bLUKJtDSpg/o8VPPcT57Yfjjej0Q4HAcHMu9wnJ68AbG+Fa5sJ64hP0xDHb8AjhcPwyQvKOA7WpK++baJvMubxMKLRWT1P9WbhCAAyG8ayZAOhs9FLTW7ooEdUwS4AtgV3WjSpuXfFKM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bdqaCboN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bdqaCboN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490afc47455so27406875e9.2
        for <linux-modules@vger.kernel.org>; Tue, 09 Jun 2026 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1780999629; x=1781604429; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24+9tIBKRIB6Fi/lgC4G5fEyDREBkP8hCdRX4h9xXVU=;
        b=bdqaCboNeSqvPSJGLJTAX4qvk+8Zu3IV9qBSjIMyPqe9aFdw4uQaAFm5TIOks6fBZa
         8eIn2+dwlfAshEneN4LYMBxNuzUBiFc7lc3/gJck4ldnCZlXZhrP7OvZbDWwZaj0MCDU
         C1xGRAGUWMQSULQ+UYoi/IdFRYhygaihCu858NsvtAiyCzJKSmavJU7fz3n9d3k8DVMQ
         97YXLvisbgucwWtTxc1FfXJWhHQFZiiFG0twHyWsyGsLO0JAwGWppEyT39Q8/kXXNRcz
         9e/0Hc6WzKJmVCrOu+RgCRX1VbUwKCpnuCwF0XYKlAcftM3S7jyGhHCAuNYO/oyatI54
         l5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999629; x=1781604429;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24+9tIBKRIB6Fi/lgC4G5fEyDREBkP8hCdRX4h9xXVU=;
        b=MJA+Xv/EblHW5CYtgQjJ++9rE5spM9/prPHZ4UArEIRbPubICXWv7s9W9TIri+hLx0
         wYbm7lTaK+YyuNU0BPh/82UHnFpdETsXFah192bw1H8VooAkz3Gh418xLYCXwzpkIszt
         dIqW2V6C3XbmyMcBAhitRyUN/VNrdCy7sOfEsldQ8EhbmM6/3MdIJUMSG75I7K9ws1sE
         qd4v1R+HgUUhSUx0auKlT2JTbEf22Dzt7DRe5+AMo0f0gCfv8ig9whikgqL7NQKsIlJX
         UxauqnigZp2P6M2Wehm3+nuIFx30e3+lrqA6qNsb/DoWz1lJ8WBiqYWscj7uTxj8CXpG
         V98A==
X-Forwarded-Encrypted: i=1; AFNElJ/mjTiUvCfYZ1aOfsUj2JU3trd3ZTHx7MNGosV4ggAteH7GFj5lvTuwzvmBdAqLuhORPU6tfM7Ww8aFHc0c@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmHvjaWvs27PA3E8QIdYp5suJ88JwRD7t4idZeHZy2t9vfOYT
	0pPXc65oXxFhhBLUo0vIpxdAId0Ep9ZxuTBbIv2anKiwChoA4PL4/P79rWJlg8mzPg==
X-Gm-Gg: Acq92OHWLTlJYA4IocIW9KwZeeUrr20LxazMPaaIBhnaAsDnvR65BeKjxFbobpWubPQ
	qqbooGZDBOxO6PgzIDnJV1UcXZgEbSYUeqWRHKiS337wyIRegVgUBIL1h/JLqKZ/XoXmkiSZnDs
	pyW+mvU8N2pnpLQPudHBSh7mR7FhcL7bQBsbGFwuM7EW6NayQ+nY6/z4hchAWxYjvOqbcIx1LHn
	eQhMhoCjNIPSSvZlukkqxN0WidfFczbYqBvpOkDPFzvBCmmQDVWg4z4lofCD44mfG9ovPyvNdVk
	Cik+ptzPPKCoFA+i0owSoIS4b7HIKs1Pj7zJmb24+KGsYzi4rv49q2J1T5Q8EgtXGt1GY3/RH/E
	X+HdM8MaSigUCpAt3gj1TKlpdC4DE7dEJeoUbfkjR4COKDPyEbvPsbH2CH8LeNG4nftfBIoN85h
	GKJYrJUjY85J6NmPW+uBOhiRRIkXVVQCULfgLMl5Y=
X-Received: by 2002:a05:600d:8444:20b0:490:48b7:c1ff with SMTP id 5b1f17b1804b1-490d72239damr17568855e9.17.1780999629113;
        Tue, 09 Jun 2026 03:07:09 -0700 (PDT)
Received: from localhost ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm49395986f8f.7.2026.06.09.03.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:07:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 12:07:07 +0200
Message-Id: <DJ4FODTOAKGE.IWG0EYLWZEK4@9elements.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Aaron
 Tomlin" <atomlin@atomlin.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/2] module: add CONFIG_MODULE_RESTRICT_AUTOLOAD
From: "Michal Gorlas" <michal.gorlas@9elements.com>
To: "Sami Tolvanen" <samitolvanen@google.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
 <20260515-autoload_restrict-v1-1-40b7c03ddd04@9elements.com>
 <20260605182517.GA2939956@google.com>
In-Reply-To: <20260605182517.GA2939956@google.com>

On Fri Jun 5, 2026 at 8:25 PM CEST, Sami Tolvanen wrote:
> On Fri, May 15, 2026 at 07:20:19PM +0200, Michal Gorlas wrote:
>> Add CONFIG_MODULE_RESTRICT_AUTOLOAD and modrestrict parameter
>> documentation.
>>=20
>> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>>  kernel/module/Kconfig                           | 15 +++++++++++++++
>>  2 files changed, 20 insertions(+)
>>=20
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documenta=
tion/admin-guide/kernel-parameters.txt
>> index 03a550630644..1013104f0943 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4185,6 +4185,11 @@ Kernel parameters
>>  			For details see:
>>  			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
>> =20
>> +	modrestrict=3D<bool>
>> +			Control the restriction of module auto-loading to
>> +			CAP_SYS_ADMIN. If no <bool> value is specified, this
>> +			is set to the value of CONFIG_MODULE_RESTRICT_AUTOLOAD.
>
> Doesn't this default to true if no bool value is specified? It only uses
> the config if modrestrict is not passed to the kernel at all.

Right. Will adjust the description here.

>
>>  	<module>.async_probe[=3D<bool>] [KNL]
>>  			If no <bool> value is specified or if the value
>>  			specified is not a valid <bool>, enable asynchronous
>> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
>> index 43b1bb01fd27..c9e01bb848c0 100644
>> --- a/kernel/module/Kconfig
>> +++ b/kernel/module/Kconfig
>> @@ -337,6 +337,21 @@ config MODULE_SIG_HASH
>> =20
>>  endif # MODULE_SIG || IMA_APPRAISE_MODSIG
>> =20
>> +config MODULE_RESTRICT_AUTOLOAD
>> +	bool "Restrict module auto-loading to privileged users"
>> +	default n
>
> You don't need to specify default n here.
>
> Also, I think you can just squash the two patches. There's no benefit
> in splitting the config/documentation into a separate patch.

Alright, will squash them in v2.

Best,
Michal

