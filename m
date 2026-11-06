Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794003751;
	b=CjRgt1jd5Yod5oheCVfaybn1wgxAYr0XJZQpa8jJSorHsqQMYhIJv3Obfdoe6qoIG0CA
	 LLATd7pdRX/5pw3EIwlhDjuPj4DFTwbabCdJcP4G8Dio7Kt2/Vwr3i1WwlJmIhgjfXoj2
	 Musk705KXhixlB8En7AQz6jUfaFn29RnFdZRA7iJLl4sr9zoghSuOroJqN3t/m8FHLTrw
	 N/BoWMk5OS1/09fO9hHGK2BMej6YwD/d99t/kyHKDj6rrjUd919uIYe2ShgKJ4scJX8QB
	 DRT6wGMa6turt8sbHlHM4vds8z7v4X6yAGq0jhVlBTj4lWtil8AKj4ase0oWGRy2uVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
	b=ya2y5BOPrwn7A6PezJMkP/F2hLbmcAq9pfmtpX0D8QK1GtRYks4zoRwaXJ+ebYwAAHxB
	 ru5ZCKv4aPeUQljejwuFlVMbcZwGd2zpQTXwlTUxFsSpWNHGhgUZmdOvyHcQXksxq2HzC
	 1luIgK72RN91IGso2B4Zrvb1PZgLzEwACKlmgN3nP5vKaOi56qfiQM/5wmaKeQOhifKDE
	 E2dfmAuraE0rV/LIv8GTk17Hz9gc1p+XboztI6uV9YttHUG5qiiZHIVUe6/82FNMo905B
	 YBJ+aSoKHvfIFYTdpZXTTiRj5fWPwa64/Kl8lFNwEe1g+vwNwif/Tw1lz71GzQglq6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPyt+i3d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779A606A326
	for <linux-modules@vger.kernel.org>; Fri,  6 Nov 2026 22:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1779A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPyt+i3d
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4adaa0f72abso99875fac.1
        for <linux-modules@vger.kernel.org>; Fri, 06 Nov 2026 14:22:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794003750; cv=none;
        d=google.com; s=arc-20260327;
        b=ZzkmMCsmWd/7fH4r3yGPIP2UUBNkz3PvnRbLoHsOkOjr9AetMZRc2JygKiSK1tmoIg
         s6ByIT8XKpsSANbweYp1QmNz9WnU/2qDBLUCi0BUzagT5AkE+FDRhNQcfbRg8m4nJ+Kp
         8T8OjcMAQIVSWdqGL+jhJ8Hyt15IEnibIQng9/ARfoaOO68fymbAE1tW1RUEvtYtPoKs
         kdX36xvlHyhmAr7B5/USA1c6froNivnYgywdXQ7IAxzU54yk4g9xNaOiqATzNLyYRkzo
         qmDKS2d7sEx1/FO1hWurNGi/7ndoEuRdq0ceX6myWsxfDdaLR+94eYWtOutkQxKx7ATE
         2x9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
        fh=a8+YXafHbN3ToOcmXJqxbiWZnCaWGICUS7wQkWavwIw=;
        b=hUCJ99CvesioSy3HquUgeO117NHnW7GsYfIT3qmgVg9AJZ+D+/MOnsuxVrEqkFDrko
         SpXnMKKxflgLykWp9cYIM+3IZfE7TrDcNd/4HcXdbH8tg6cVe4MMbo7Dtm1uDRfbvOaa
         1KwVJ1sINfhFyjZ5KhCGH+2xHLwKLbFVmFeAy4OzX7uJzFpNVQXQ1SEONEKID5ZISdpT
         ley7P06zirZY5XDzDzFk31NvRXmBU3iTcFlIiEZFt8i3UTTxp57GHVIMZhz+uAR8tOLV
         aniMjZMALQeRybdtZpnPuUVDpj2uVrkgDkgh8Bl7u1G/Jg5TqvmHKjXXdyRcwRgcYe2L
         Aclw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794003750; x=1794608550; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
        b=cPyt+i3d95+KCeQQkOH8F2rDwgzTTfJHa/LbAjB9yasv9CzJ4zC/3OK589tpx8JtfR
         MeA0VXlDYyh43VNR/VlvoSt6nkPIKqEFFaJVQY+/UvcaCkzf8hd3oHPbgmjkimjnS9Nm
         1WYuMUgP5Rgy3nQLo+Jap9gUD0nQAbCZiNC3XPhFFTS2OjD60vbUFT99fK6Zi1V4aN5t
         wNVcja6zVclHdwENvR4xakimgq1AmYbgb3znnVStoD/Y1GVMaGpvml5UQj2b7gI5yX5m
         LNi4vDQBxiiBhLNmld01+CSNfO1DpyfkwvgspJL4lsmo+pXddu7wrLQ1Z7PFl4YhDMrl
         fuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003750; x=1794608550;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
        b=I1O7pv9rUi2rvAC5yf/sJJVzXidQ9UJQ5+7zfg5q8u6XEPEUv9yKnydjykGApUlP/n
         vQ+PGx4rUBJ8Bu2MhR8/9j6QES2Q/rpgGo8lKrD+tv573+I+pWnhO63s+BC+emY115cT
         F6SVfRZkza7BALcdxOfD1bdBlU4mk84WJuauF8+7HJPBR2+dMMFSo7xZLliQAsWVS+7n
         FSxAp5D/NmTZwxOfmbb7plxQrOdSs6HjIrg/7XeTUgyDj8TBGblABEvLo32/jlwUOrL2
         VZ/JEOxO+QR45bpVL2Qj6x+DllasXj1P69sqdTiArpvda11YBNqJDXLXjbSYGfChAnA0
         m71Q==
X-Gm-Message-State: APuU4Z8e+3n9thCKBOlWCY9n3GXP5TjIdgWi26RvJyEqEP4i0Pu7CNHM
	HwxicdXxCzbZ+rz+bJEa5ZS1lE+dXWUG17lnc9BjP4w+LJsBlt3FXeqolEy3krCbMvoRCxTNRAr
	XfqE2G+TYzDChuSXw0Ob/DnV/GZDKxh4KKVXzdvU=
X-Gm-Gg: AYBFou2a/3rlz+0W/Q4bGSH3X0jImBPnibBdApJGV4KzBvxU2NAunsQimRewglGMXMB
	7l1+fsdxNKR4S3R7rWy9ep57CfieO4zaKXRCVlXen14mYOqN8BL09Ya9vvO15piicNt1/9Md8Ro
	+rlMZBrRve8Z0f0G/JkTo/71Q8sBusfK81FqmQiNi8IoBm9VVicJhqnPSM3n+Lguoh+fhFoI7AV
	GeUpG5aaLuDD+74k4jmbpjMo4aomGZuZj1wgHJIG+usicX8Y96COH+b3/4G7dfZecGmSxNKazU3
	e0+5k1ihytoZzrquqWslrV0Wv4ByJR5Cs8Vb2sDUISBXqVfzJp+jUPh7Gy/CjyyTjQoHDGi8jXA
	h9J8WgOyI46cF7DARsn7VwmU5M/4EiMSY1ffl2qfdRYF4cg4gXeVZrX6mhdHmZPWMVHNsH8kYhK
	XeOkPbZrOfmfYYN077DA==
X-Received: by 2002:a05:6808:2f0f:b0:4f5:214:fb96 with SMTP id
 5614622812f47-567fd5bde12mr191162b6e.42.1794003750060; Fri, 06 Nov 2026
 14:22:30 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com>
 <20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com> <CALr3rD93RT_=w8VB6aKfuV5crbwXK4Tffq9bLD=eJBj07Tv1=A@mail.gmail.com>
 <20261106111154.0e09925f@gandalf.local.home>
In-Reply-To: <20261106111154.0e09925f@gandalf.local.home>
From: Mitch Hen Chez <mitch9654@gmail.com>
Date: Fri, 6 Nov 2026 23:22:18 +0100
X-Gm-Features: AclHuK-7xQ6612mfqm3wxXygc4s6PKZhQY2O295ToyoiA417T-cVE2TxsGyvghM
Message-ID: <CALr3rD-A037pOODDLMsOcFwFbQm2d=xna1sW3KMRJtnv41raYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ftrace: Drop weak function locations of modules
 when loading them
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ah, thanks for clarifying, I appreciate it :)
