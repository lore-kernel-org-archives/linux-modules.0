Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793970848;
	b=03Umpbvvs9qzb3/w3cgfrUH8x+QJR9I50hDp44V+Ck15ReANEBi78KRKyO9iHlNYA1y8
	 tQrI50H26yS/CLGJkhYOD7jgXxCeQVvez8VKZXHRbzUrT95UqEok1he0mwGITf+fEY5H1
	 TPqTVXtdJWL5Z+1YU8e3NGhxgJlPUoLXL3lQH9fA6AyBii+xr8RNruKncCxIIlhxOvMQe
	 EmT/PtJieRYxt0gYKUqC1dYwMo9jgYL/mMC+B5TZiSgMDe6seVTFLtqUwItFxUNWggHAe
	 SFkNDVbD/1ww0GyxygkImWsmzroTKtVa3MskDBUd3zIqZ/3N+mf+wngTFiUSdpg6/ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
	b=DjEBnakgpo7jXnJ5xyxo2FDS2FSPek3QQeIlGSpxi+dEZYXZfHHZclRDUdFMhi/ze+Jg
	 YveZVNsCCUuVEX1cgsJlFFJe+bbMBEC437bBCfZSi71/77KR2rn4IAgDhFWW/zVG+jt0V
	 ganK2LP558Rc4vX1u1gjbd9WRLbJudKy6D7iQmXyW0VpmTe+gdSW8TMZ1zScwY6hfHQes
	 Id6UILrGRkN58aoTWSVDsQrbDj4moTi1KWb9VzdYVkVZva2oXk2fRv/hVskO0JPYb0HBO
	 IDIBDwCQS/Di6S+NXx5r2pcUDJzQ1qIJmbFgfWFSx6BkfxyqGrDkyxuut9JnDeAvwhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwLt3FRK;
	arc=fail smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A761606A330
	for <linux-modules@vger.kernel.org>; Fri,  6 Nov 2026 13:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A761606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwLt3FRK
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so346163fac.1
        for <linux-modules@vger.kernel.org>; Fri, 06 Nov 2026 05:14:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793970847; cv=none;
        d=google.com; s=arc-20260327;
        b=WJRtwpvSCGYaLFPqfeJeYYEB/PqdAeVW/pKzqbbzTpQ07f5faX2TzI5SBN+heGUarG
         jtaUeK4deP2JsQ0uglQeZIJJlSdc8RLz1N5L4WaGC7N5Pat571D7hkg5lWVpKpZyyGf+
         rJvwQu7M/FSZNDia4VZnHAQPwnUtegbVWzPvpINo4AaYD/lWjVO7SX+0ZAPw1krQ04QV
         byM1Hfhi1YHoGlvcrXUHHiVhjV+DpgGjlHRvEdxFVTiZJV2tIHXgt6FhTpH5U3tWFE5B
         WZOfSD2GOgz6Pv5zGuSTYm6POZohWyn5xnGnLQt/9u/BvYh/Ug4jlsA3TAF1zggCp1js
         XfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
        fh=KDeY69KEnlISvyPFoBaBjZQ+WcChpl1tDVa4QGKiQO4=;
        b=IH5ufTiBzB/v8CnMr+VqejMvpOt05VkGkzJ2bUAmzDJa6J3UXbm8zridMn6xgPSp01
         fP29z7XBiAsIV8vyFbO31J6wwVpMFAwm8O8ohtj6qVUdsGfQEVGFwiXlhgIGdYIlMbIe
         NKo6uq6vktdWRPtg6OzwtVuuRJRLlmDxv8Wl4jY8JAltgJtNECDI6kzl3zQWT+SZW8UI
         9KZ/oOgwTLDixmc7DP42Q8UjnxFjI/CHzzjSG5l5uVsj6+pAZsB/YzU8krP5YAj5xpnJ
         +qz/qTFms2Lj4WHCA1c67WVer5YNI9+JxfyegMU5BTU+aKN76+aJbOhKEMQBUQvbn3BD
         rIlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793970847; x=1794575647; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
        b=rwLt3FRKaib2TbFpjgr7R2B5jwDhmJgnrUZ42NuQTG2wKLmY+40UGIeF45BD/GISqz
         BVCDKLRZanqeVQh0U2YPak+Nagm4TNbvzx4lNoku/O3YcapsvfHeuqVgZ8lZ9gA7WlBU
         FtThgZOryzszqriE/hmExA2KW5x9QEJNz9St9K9EgNa7C5b2xz8EWZ/HwOJoESAGpWfa
         G0qvPeEMgkiD581SCsW0KtAziRF6vwQLOlO18x/nYsmxifFXTadrIlP6QuDcaf2YDHZc
         j5T8pVmdZ9jMtoWdLD0DU/h0oyH8GLM73WauVLnljRW4l9KCeSuj1/nKXhsG5Njuho6i
         iQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793970847; x=1794575647;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
        b=sl6baO3BYB3MSN/BL1aWxMH6a3P+H7y7u5yiOW3zToAikOAqReThX0FlpkyX1Higc2
         XgltTNU28/WaWFzWNCre87nV2O1JHwD9YOTsYoutnOQHkwI195JMz66jVFZdgOc0q594
         RPjzdgQwrbqQkYWY1oORDw1KcPKe6JXDsh6vNPVh7pkZXqsQ/pI9ab36VyvXZB+/E9KQ
         hwh6KWiytXiVDHDGFKBV6x7GecXVcwSz1HD13j6mZXJTZGAVAeDMSewldrZt3azp2l/T
         TDu+YNPEM+FlhzI8c8irDJVzPanzfNe1lMZ5Sstw3w3eo0CU5qSl5I/ewU2J+ScIFseV
         bXrw==
X-Forwarded-Encrypted: i=1; AKwUvByfJgGewr0vViT6siDDhojpJ6urx1KzD68GiaJhlnIo4AbUM5AwjH1FyeWqcEDJt93R4nq+lksj2wAolAQC@vger.kernel.org
X-Gm-Message-State: APuU4Z8REAogc0eJlWR4xGVZugL/AGxJrFwfz1/raxyRyQlLXxXexNUc
	LIgd2UizkQGBu403qzLo7wpjK4kH93CL23Pg+DdzescKEKRPeTign2juSCGgoMuZ+zFwmU1TIZd
	xmdCWsmfZwGlOy+8G025h+/JaZRgVec0=
X-Gm-Gg: AYBFou2Mj2Xd1yEutZJIJtSarY7bcbq0iUYHsyOP6BT3jdE8Q1B0/sftY9O+DXAgroy
	bcg6OWyfVZ0TvneoBlcCCIE1I/pBFm6uIjyrGG8V3sFhO6yuVn/erVtydAc7HklpSZlExTpJP1Q
	lEi7+hDn2GgDsgt3t87U6BKjatVmqVlxCLLwonbrTmh/tc/MPsUj5DTsZvdKO7IFtvu/HaOY9ON
	I/DxS9X/QI5WzapQIMhGPPopYjWxnN9C5arGtBHoy0BxW41vihckv5eJeR+drbIuDZakd+etNNP
	KOPemUR3sBkQezqXnhc0XqlXQZ4oh7GJka/1zQmhHUvwGv9TYgsrgMSqnymMhz4TWA/vKJxAxD7
	uj1z/wXl6LtAPXT9qA3/rUHXfg2exV7If4jiSm78RMHKXWx5MGCKWCVtk1H7Ro9DIFC/B5pnrEg
	mU79AYiM3puj9G39/giw==
X-Received: by 2002:a05:6808:4f6a:b0:4f2:ac42:656b with SMTP id
 5614622812f47-567e098b95bmr2036164b6e.7.1793970847328; Fri, 06 Nov 2026
 05:14:07 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com> <20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com>
In-Reply-To: <20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com>
From: Mitch Hen Chez <mitch9654@gmail.com>
Date: Fri, 6 Nov 2026 14:13:56 +0100
X-Gm-Features: AclHuK-4pAGkIQBSKZ8F_59E3K5aQv6zvde8cyI5-gaZYBULE-9BuBhH3eqMpKo
Message-ID: <CALr3rD93RT_=w8VB6aKfuV5crbwXK4Tffq9bLD=eJBj07Tv1=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ftrace: Drop weak function locations of modules
 when loading them
To: deduce@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	David Laight <david.laight.linux@gmail.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey crew :)

I was also seeing a stall (~2s) on my Fedora 45 machine, and when I
applied this patch, my userspace startup time dropped from ~4.5s to
2.4s.

Hardware: Ryzen 9 5900X CPU, RX 6900 XT GPU
Kernel (base, as well as patched): 7.2.15-300 (fc45)

Would it be possible to have another review pass on this patch? I
don't want it to fall between the cracks :)

Thanks,
Mitch
