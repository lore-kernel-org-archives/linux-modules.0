Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396CEAC7;
	Sat, 19 Oct 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729351532; cv=none; b=Sj/MnnkzozSCCxIny1cY89RTb4ZsVa87NEHidjWPiHnXvuUy7GEPBywboEwCvzYdBa8E8hb4F6K+PMY0FrGm/ZpNcDozWequWxr8HPfmtj70xednx8IvUzyPyzN5dTqesgNcqozcEs7w7irx30mtaP/SEyGp1p5oDT29zD+OXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729351532; c=relaxed/simple;
	bh=VGpUeFJ9CXGCHzG7wfKHVaaoZcBpkxpWYGXVicoxglQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hH02stmW56QFB1q04GhWCqbWI6LbojGSDId99yzzUJnoPaCcKOKwWVOt6dtN3NQnLNX4wLWexkdOmEeJH1OJW9cviHDiPSVHrtsOK1bw5GXOyaFu6+p1o9FUXrjYA7mnU5ZfF7oFjZcopwvCj1OhwqeN2n4yW9hJ65+DrdP658s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyG7JtEC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyG7JtEC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9a664e65fso3587597a12.1;
        Sat, 19 Oct 2024 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729351528; x=1729956328; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqOxPIGSWxdyAWdKZgznaaC0m5Gn9KejcbfH9xhAtts=;
        b=AyG7JtEC9HfI0yKWwntsATxsdPG4no43mLLP6mX5gGIEWPYwv+aMbpDyIlyLzAaMqc
         sPKyEMcX1U1DwUMnoKz6PZrRBGAOOVw0Cu1yDAoOQyns1JaZG3oUbP5/fpDVLSlEMmIS
         dNfV8/n6sVxVtZFExUqQMiD6PF+WBzEMjDGUbXDnbbQ5NEaDnTS6Q8j3c10HaijrcDlU
         Ce4NcjZ2fnq57sGBxb8T8ghnS53+8uhM14P45TRtuA4b1jmZcGsmPoUSg7+XlkUtRqzu
         wT5hcJC3eDZAZhcJ/lmWNnLwOHXC3d9ou4z3HUN5nLnbq+z3CH6qzrbn/QlUI907Q5TY
         J1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729351528; x=1729956328;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqOxPIGSWxdyAWdKZgznaaC0m5Gn9KejcbfH9xhAtts=;
        b=PsTOmZOBZqPGNEUCX3Fxpa1PYNWWUFoZz+NIFNYjsF8Wf7lqaASw7/4hZTld8lwYIR
         9r1rCmseOOkOfqMycGeQbMnztm2k0nCptgC1me/siFi8aNlAECp/t3O32HsDC6ypUAs7
         YSUrhT05UNsl7iS1jrK4m6YS2UP6Qt/rZyFaC6305S1DVW/DedRiLtEyAWxqsIyVW8CA
         Fuoe9pQXyxq2oPqOqJoKJwX1QBWAPanhcnHf8Z2+Ljw096U7+RyHy5NuxUfdZSbKct6J
         rX+k9ECtwLMu3C54+nVCEr1BOBO1570NfSKX8rr/ggZCoEigPkvifB51nUN/bc3k0nbK
         8jkw==
X-Forwarded-Encrypted: i=1; AJvYcCWLQ/5vIIqKBYOUUKPjhXDLXCdmEZBQM6mTblGSbxqiXzvziu150wtEYifdcKuZ5VjLFSWy8rdRWJ69AY8=@vger.kernel.org, AJvYcCXMkYo0ZYsN4Sv4ySEnUbGexZX1C0P6UPnjDrxarM/89enE3hC8aHr91c4rWTvndv+LoL1i4RDDhkqx8J09Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuRjGv0Vdwfm5VJGMfmBp9RgcerHfITO/YfKdbrpJbyXi0XzG
	gLtD8vx7XQjSq3t8a/14eZlvW0w11RYhWx23tcaFTAzdBg5eO1E=
X-Google-Smtp-Source: AGHT+IFWDsDPsXARX8DbF/3BZ+lp4G/6LnDqEvJX/elkC+I2gkZGFfudkczxuhVBVtCUiVahi5/uww==
X-Received: by 2002:a17:906:c150:b0:a9a:478:2ee3 with SMTP id a640c23a62f3a-a9a69c970f3mr535012566b.40.1729351528224;
        Sat, 19 Oct 2024 08:25:28 -0700 (PDT)
Received: from p183 ([46.53.252.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c284dfsm223950866b.197.2024.10.19.08.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:25:27 -0700 (PDT)
Date: Sat, 19 Oct 2024 18:25:25 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: .strtab must be null terminated
Message-ID: <abafecde-06b4-46ae-9249-2584f6610763@p183>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> +	strhdr = &info->sechdrs[info->index.str];
> +	if (strhdr->sh_size > 0 && info->strtab[strhdr->sh_size - 1] != '\0') {
> +		pr_err("module %s: string table isn't null terminated\n",
> +		       info->name ?: "(missing .modinfo section or name field)");
> +		goto no_exec;
> +	}

Reviewed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

The _very_ correct test is "there must be NUL between last index used
and the end of the section somewhere".

.shstrtab has the same overly restrictive test:

	if (info->secstrings[strhdr->sh_size - 1] != '\0') {

But, of course, it doesn't matter in practice.
