Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC220E32E
	for <linux-modules@vger.kernel.org>; Fri, 18 Oct 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252889; cv=none; b=qIdrxfHX27nI5muUfzelP7rUDEhiz88LXcJ8kDWb0Z0RU0dy2jqPXqeji49g6fLVARjULqrwsIYTi0qhFfRLMWw0+OqIufVksAOHMSYNgYaHtSc0Z5TthlhW3Tj21X8GD04C5IyKiI+geiL37d8as8dBEYSrQzLEMxsx8dCuRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252889; c=relaxed/simple;
	bh=utnV90br8xuHSzN9hJQ1xA6wQ4jpefDTb8dzkSwQru4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXuELMOvyk88bTHI0NF4jsdDCRY8ChBE6DRMB+0FML47kLGJS3i1hEKXgqlgrlVAwTtvA6SvWxKA1puyNmL1eoltHWdRMYsMHSkQ1XdzifxkAb6INS3oiT6Fmt//UZIc1hh226rWLpNlmHF7B31KYaO4NRKzk+kEmCLBq/zAUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYXdINr/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYXdINr/"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so21974321fa.3
        for <linux-modules@vger.kernel.org>; Fri, 18 Oct 2024 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729252886; x=1729857686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utnV90br8xuHSzN9hJQ1xA6wQ4jpefDTb8dzkSwQru4=;
        b=LYXdINr/LpDaSZHnwrDZD68j4gPZJapPybQhZuHSmZAUUJlSU0/+o281vvT5o6JtYj
         AHBoWbRjd2w5OMQhtoY6RcbUVLVkg2IWB2lCZJMv7OvfELA19jBXp0fOO1nkXalJbaCb
         2E7UaTqo3JSmnMh+c+12Kfvbz2oDKzGru7SPN26+1k6toek18i1Z4NqesV8xo2mjL73p
         7BMyE9voHiIsrKYqsnMYfbR4qBGa7+f3i/sg32wCwTsJVCIX5eYFhsGUQxrA2+GDLd20
         z6ssGpppoRIYiTuCLL/UyhwiyZNP9H+V9p5yQlBDPliBwY3a4SXPL3fgzgZsap9NpzqQ
         y/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729252886; x=1729857686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utnV90br8xuHSzN9hJQ1xA6wQ4jpefDTb8dzkSwQru4=;
        b=jFtvPbAYw9vUJzBpEmiF+gv/uEj/1kaKW5kwdpJxtbFisCPp7c7dxZUJPTa7/R/mSa
         AH7l2LUSZxw1/vGuhHt9QzXgbB8zNuQmLaQK/CTv90ljoofOsz519I2K+nGGwMYJUb6d
         +8ePxtfUoYYiDETo5nBP8TSdPvpMxKBVJCLPp5MlNQGlDiQi/KsVbeR8LcWTpgnd6UgO
         bgxzIFqw7abXIwRtBaFlXBRNc57Di+32irafo3JCaiHHhAGWNSUwKPj0BIFam7mqjv/K
         Xa4VZlwTTvMZdCUJUGuTlUSBbHkMHj79XS0pOB3ylmid7O/XM17jw6DSOuoCSufNiGFs
         /mPg==
X-Forwarded-Encrypted: i=1; AJvYcCUfXWRQkY4tmAcdzTaO0al7lLi86GJo21P5uthAY9RWVIdOG5V0pzfQEpSYaVEIyCE1HUDXq0Z1oKGqzCME@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVg4hWAHmAjeLemVfCxKFvmQ6b7Oo/efwlcCcroo0itTYL1EQ
	nNNd7rAthW0G9u0GmMr9nJSL2UFNnZB5/rrjMTFFCkSHxu5xAoK3QnRxt1YLj3mczeD3xTTWJ/c
	vOjDFNW7Arcl6Dap1Xlki+Qai8Og=
X-Google-Smtp-Source: AGHT+IH1nugEmnMRkW/Ddq86wbGe6aZBq6Begesp2SmZUlRZZODPyEPSPVjFUYpEBtQKWYdXhDv8S5xFIKylUpAnSg8=
X-Received: by 2002:a05:651c:220d:b0:2fb:50ce:ce94 with SMTP id
 38308e7fff4ca-2fb82da5afamr11867751fa.0.1729252885562; Fri, 18 Oct 2024
 05:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUULLhDyScuQnM4Tx+JD9xMFhnKVkxepUK_o1jGhJGo+bQ@mail.gmail.com>
 <CA+icZUW_K-f-ATDuvtsjXokx7aWUcfh7XpW2JhxBeegXp3V4xw@mail.gmail.com>
In-Reply-To: <CA+icZUW_K-f-ATDuvtsjXokx7aWUcfh7XpW2JhxBeegXp3V4xw@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 18 Oct 2024 13:01:13 +0100
Message-ID: <CACvgo50-oorSp+70CctrxQRt04T5bkrO-z4uX66GeBFXROxYZA@mail.gmail.com>
Subject: Re: First experiments with kmod-git and meson build-system
To: sedat.dilek@gmail.com, "Marco d'Itri" <md@linux.it>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, linux-modules@vger.kernel.org, 
	Tobias Stoeckmann <tobias@stoeckmann.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sedat,

On Fri, 18 Oct 2024 at 11:48, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>

Have you tested the resulting files, or you're just building testing?
In case of the latter we already have CI which covers Debian so
:shrug:

> looks like etc directory was not copied to $PREFIX.
>

Yes, meson behaves differently wrt /etc - not much we can do there.
Ideally you can check how other Debian packages using meson deal with
this and borrow the approach.

> meson setup --prefix $PREFIX --sysconfdir $PREFIX/etc --native-file
> build-dev.ini ../build
>

The build-dev.ini is a configuration file for kmod _developers_, so it
for packaging purposes seems off IMHO.

If you want to help with the Debian side, you can reach out to their
maintainer Marco (CC'd) via the debian bug tracker, email or salsa[1].

HTH
Emil
[1] https://salsa.debian.org/md/kmod
