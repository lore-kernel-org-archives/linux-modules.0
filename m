Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75338D3F9
	for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958590; cv=pass; b=AwXHDCAcOBh8CRRpcXVdSuRh6tneDAySb97lF/S0m1JacUfZvfMuswHIqq5306+7QMllWy8ojjbyWf0y3HhnkfWw01nXuXb9pmRjQgsDRSnQ/ftxBdPCh9FfSapYrg/PzGyqqCugk1hynMWx462EdTrKMonrjscgUEYPrGf5M9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958590; c=relaxed/simple;
	bh=n1fDnNleKBrs0gtz7rwKG/FuFD+q8E+8cLS2M1eyGXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6cp7LYwKsLUJyrMcG3vH8Kc2bE6JR2Ap5HxDqkTRTUqAy8UsmFjpnpCYKe2/YYhtavNyz0HgGxQFKnR/5lsptPPEx5q67YVIYBJrBQWBJEO1l4/xuk6k832bnRG3RA640VYKSXU+NkhE3gG9VF/lpzuVG/3w1rOzcSlP3up86M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkM09dbd; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkM09dbd"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f5ae07e2b5so1043550eec.2
        for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 01:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779958587; cv=none;
        d=google.com; s=arc-20240605;
        b=KSw+5EzpEYHUNMizbvN1cmzJOy3QBE03UwbFHOJcYa3j1zln8X8tumK750xTg0ryhD
         jOj7rCUZadG7uNB6Osid375AWf7u82Pp9L2Vjbv2mQDPY3L5r1DiJ3odi30EVMUN0FVZ
         zRw+CaVAY0GboeQPcW8ymXavPiU/0ZKHDuUWKAXcZu1JfHGsyyIywdrrH16xyyELpt6A
         HGe+wGMcRrtlmjzw6AY2utSDd4LeRbiXp9lGriIVYRAfeP4WTmx8ul/OZA4vxRhDsyG1
         PgUaumxEHcwssMiHDRFu0CO8MrG4G24j29bULMU6XJ5iSsl99eylNPqQ1joFfK5heQWB
         QXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1fDnNleKBrs0gtz7rwKG/FuFD+q8E+8cLS2M1eyGXg=;
        fh=yD6O4iPGXkSNBv70vgKDipUxxkxYDSVEoFm0OfznKE8=;
        b=ZJWuDkrTlHcMB3nb0ULlzPhEDuv03glBDB2FEctyos3yPrGcQVivieSbFYoHtejQKG
         BcFn9tqGPaPMaOs4yP8Ko83gjFV3frOsQ7O61QXnyQF4bD2SvyYfM8yBdDmqJrCXZisw
         L8YEYrhe8cmFgDwaSBXt1HNI3/kRLMoNgMQI/dnsb35/RbkSFJybloOC3ac9yi7p+ZRH
         pqyQB9dQ2EDrfWcZX3PKhm5ZpA1ke5AedfZCBI0nGLJ9GuaXTgI042ns57Rr8zdKoZZc
         kFR5KkzHNGAwpwXWrIoBvadJ1KihKerBx2Mq8eGbCdqFIqIUygzKVnqi8ku+gMTE6trx
         brpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779958587; x=1780563387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1fDnNleKBrs0gtz7rwKG/FuFD+q8E+8cLS2M1eyGXg=;
        b=LkM09dbdGD4df4xBtxk+um8WGgilhwsjWeKMd+7aq+DlEFgT2ycAbqWtwVVTFoMrBm
         IvWgsCOpAj2F8PY6nX3yobrlBxelVWdr9fkWbPgwrOUQMh8DVVCphRzWmYq9pOPqblL0
         3aE2ZooMZkYZQY8v01kRtgUKLNpyqYxbjttN4XVNKC2IyUBT4+7ksaEvY8PdiuR50eJ9
         WFGiqbJlAobeRrI4H00Mrke1ithgmsHqvuICq9+npawh2FyYDDRHFghNe+dBXLascuFk
         eUrQpWw6w0/wBUjl10++kDc09uMpG1gDaHrQNEyXjN7v8cRybTYfssJY9e27yOG8Rd/T
         h/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779958587; x=1780563387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1fDnNleKBrs0gtz7rwKG/FuFD+q8E+8cLS2M1eyGXg=;
        b=jzlNs+3WF9JPSeB95PQPgj7uWvCFqnOxrVOt7UPeICGpkcdGRXIyEGa6atn63lgB/y
         QPLBVREshT4EvKW4/gnZK2nQfZ/E0pX+Wma+dNZ88voc7EnwKckqo26DWGX1trGDoyj5
         Dh/FIqO4fV2x0Otoky7XN0iL/MTrf3KiQGNZQG0P2Qf+Ri6LYtCIsYIttKbvHdvuerKs
         2hXFviQO5a/YnIJDfq+up/vTyhoPcrU03X8+ItoeVv3294MwbUDodCyW+QKCac4qLWaX
         eJZG5ibj65OjIAsW1B/fPIfa0sCgNHwSrSGgUTtSZi7aA5RLodtMu0Lz4V0H1dOGJ2Xv
         Batg==
X-Forwarded-Encrypted: i=1; AFNElJ/o8tmY6gZoUvxKy/a41zjs84VMaTmjHye6jCuu40bwkfFCUXmRI8kStKj09ZxFrR0y4iu6AVFapQmCTR3T@vger.kernel.org
X-Gm-Message-State: AOJu0YwzX2lbJ9Xsc6aeWFW5yoLnjq/JGAN0O60hPaDDYcXJdE9rVqfs
	WJSSUc+Erd7vYFSkoJgzTnO5PGNbiF4DSVdEbGNezQnXLHWrmdUg7D+6UCCdc1iJjrNmEFwZ2Ya
	8Q+KdAG9KkhQ6xhADlvksBcLiiXYTjVw=
X-Gm-Gg: Acq92OH/FRDCNjJc7MZLynluN5f4hwUZTkk3gAxDhYVTztyuSmgDb2HlhuhqYcSh/9y
	y2Kh9j8pKITtgttdPqk08lWJmCgZ9syRvixHFJp8S8jrDcjUWgOc93uvkTQy+a8Gu3nt5Xb7B6R
	bJBckytTeqs0N/bWA7PyFIhX8ReCgZvQkf+T5KFGmIEL1zScZR8oCMY1fsnZf7cy2WdH8pHaHJK
	Qm16AW4NHtxeocQoFeF8ROMlO7dCHRp2iT2Gf7YfTRb0rYyTEwuf74o8aeLk5d+Z8vK9XBOxDl9
	WlWuWdroaex3ZhNaT1kscpormX/hqMI6A4nqD5YpVKSQTBH1GW3e0rGE0er2a+w0X5JW+4wkmCs
	9g4MMsAygJJefNKnPEVo02yn/+eOSmYmD9g==
X-Received: by 2002:a05:7300:7fa1:b0:2ff:b29b:87b with SMTP id
 5a478bee46e88-304d2eeeb17mr399285eec.5.1779958587122; Thu, 28 May 2026
 01:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521161405.64042-1-SisyphusCode0311@gmail.com>
In-Reply-To: <20260521161405.64042-1-SisyphusCode0311@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 May 2026 10:56:14 +0200
X-Gm-Features: AVHnY4Jbw8eIVF4umMpWmAnu-SI8-OZd7X-hafIk8ezroHFvi7Ygb5a2BmJMgxA
Message-ID: <CANiq72m5GZp_p2HCgotBaevLmt1NrvzwrzJJK5sLUEwxeVLBdw@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: add missing newline to pr_warn
To: Kenny Glowner <sisyphuscode0311@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:14=E2=80=AFPM Kenny Glowner
<sisyphuscode0311@gmail.com> wrote:
>
> Add a trailing newline ('\n') to the pr_warn! call in set_param to
> ensure the kernel ring buffer flushes the message correctly and
> prevents log line smearing.

Did you see log smearing? IIRC this changed with the buffer rework --
it is still the convention we expect, though, so the diff contents are
good.

> Link: https://github.com/Rust-for-Linux/linux/issues/1139
>
> Signed-off-by: Kenny Glowner <SisyphusCode0311@gmail.com>

Andreas, Sami, Daniel, Luis, Petr: will this one go through modules
too? Otherwise, please let me know and I can take it.

(Trivial conflict with the `pr_warn_once!` one applied yesterday.)

Thanks!

Cheers,
Miguel
