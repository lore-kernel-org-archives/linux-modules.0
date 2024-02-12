Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DAE4D584
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775817; cv=none; b=dcPoXOCxRzQELQnBdFDeuR1/HAGVZuhdlmXz8iOFfoKGdoq8rIGaRtdgEdKn4nQxp6oB559esSdjY5OfSCBBnshDHnppxJm1Bg1GN8Vq73AjLBem5vWe5LjMr1Icp8dyB9w0n+ppGTAhh26C/aKpzl5xX5cbmnLgUGYNZa1Hv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775817; c=relaxed/simple;
	bh=x2dB2HwYcw6FEFcyt88gNSz8C4rxKf1AxqpiQ+NBli4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGTIIe+k0RxUnN3vL74PuPsgjlKygjiOovV8cAw5lfMvtrbm7lz4r4GQ+8Ilk8bOtGqbD+enYBbs+3LF/6+HrDsTk5Hj+r0MIwobVJEuZAYDxVxeJrj9Z9Lorz9v4rk3ZFF1NR4tcKt/uMQBwkCQl3NHS2BgaOBjz+o6Kc9eQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f/hD+jRm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/hD+jRm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e0f5934813so268206b3a.2
        for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 14:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707775815; x=1708380615; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SkGi1YlkpzrNgkK7fsGdO+nBxolzeU4HsB6lcpcl19k=;
        b=f/hD+jRmmD/nslR6LOtigo4QXPAJUg77aKa0j8xZ6fJ+CLUWVkHvb1gZf5oN8WqpPg
         dE6jNHmvvmbX4CPhzwJqU1rqN1Vu1cTaDW4hmAZb8bNPcTMzPNdvxcvcA5FSeqzyt72g
         KlBKpWvqMHamP/P8cqIPHy2pvlpoEOQcPKstg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775815; x=1708380615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkGi1YlkpzrNgkK7fsGdO+nBxolzeU4HsB6lcpcl19k=;
        b=eRQ7OPcgydF/iE6hpEbG3EAgMBGebCcNBY6dmpivvX0fs3FTA8ots34xWFUQCCwy72
         tPak+ox4baeNQwb/015l1S0/RRp1opCAA+EJdLlYS4DzRedUTbbe5GM61LrtooGZ1MeX
         ox2M+454m8amljtpIuMvYofkiw6tzfj1muFPLNoV9cqqIS9gLD8E/H95pNz5F4dBfHwM
         2Wc0rgberH2FukhbgJmCDcBKcsbdRQK87XPn9yFxbbp7QV9JXI5DfxokiVecBzE/xF78
         eyc6b9LT+/7YEWucxYn/vFBselKtTmG16RdpGenjqege1exGFacM4kMmx9TZgEEPAavP
         hf4w==
X-Forwarded-Encrypted: i=1; AJvYcCVQJuMAcroWIvJuy3UbKauRIfuBBD43clVSnL9k8HMgZpXgcFaWdAn/gTWpI0/bbJtWK7vpTGWpfIaZaYRKxT7xNaYubLhrMcNBGy4HPw==
X-Gm-Message-State: AOJu0YxoOFaB7G0s+XdCI9JJnfXu5dwyx2SXAI+Wqgudy4sOs8i0Kj8o
	M6r7gUDFJ2NkUl0FTMydvJzuxE1e/jG4Lf73lCCvL1IU4yyjqFQT9Q7Ci168aQ==
X-Google-Smtp-Source: AGHT+IHpQno5Gs03vrNijZSLYd7CPW99yv7uxK9TZvUe9tkILhybemJJepHKCzS3OyHmktw5rKj2Aw==
X-Received: by 2002:aa7:98db:0:b0:6df:dde5:6029 with SMTP id e27-20020aa798db000000b006dfdde56029mr6510317pfm.19.1707775815028;
        Mon, 12 Feb 2024 14:10:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOM1Q1oyTIbMIm3/8NgYuKUVkfTyBovJtGCm92Dn+6W/OCl9Nrv/9i724olnZ5KO3Fz5WtaYNAxg/AWzfjP4i6FjATD/SDxSr/7MuS07SgqtcyB+KBkjG74OXwCYRnrUCULqm/FS1x+sDsfAtu5s6Kk9iGqitIj4DucCWD8+Hl7h+hD17lQD7sNGOUbVALXnbpIsgXE+6k9TNDm2VZqP1caSvISBQNoE5caPtC23Ze9Rpx+Gy1DKQW6uVG8x/pp95bOikO0VDHbBRFvlHuN1wOhy02IGklmdfe4h55X03v7DqS+SOQ/623AhBZyVQ31lQ4xSd6Qt0Z/YpxMLduBeenZOufyU3HUaY8oQjZb7JQQIODmDHwUbepfiMNs+GFKMo6YmScsmqReF1sHoBGSpV0Sdv/8rYGdPSMZG1XpAooQEr++lm34XyeYmZKniSFeLuTEEq0bYTHwevd/8a3xdOwtmuY+OrRGw4OipMEe1qbiuJDEtXWuFvwQ2gseYYcqX0Mmb5sma7UrIoA78CngK185TpVFMCib6jjPZmKaOU5oWUrMVPwtChDDSkb/8k0l8hdSdJyz+tcq0aiBX6NDtWHVtFZ16gGOHy1doeBfWMHyKWwFsraOU1+xUE6dqPg+aliI9BzB7SiLIDJ3fOw4wmqBnXROPnqBVbHUGPrLJvvvEwsBbfzcKgjdtOHKHfJam1UoC1057u35AfN2U4nwohU6ExKIcdFgnYFlt+7gwEzYI96N9vuVVfFr6cGfdoD5EdsOJ4yxoeWOQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79e4a000000b006dae568baedsm6042528pfq.24.2024.02.12.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:10:14 -0800 (PST)
Date: Mon, 12 Feb 2024 14:10:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v3 04/35] mm: enumerate all gfp flags
Message-ID: <202402121410.2AC4CACAE@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212213922.783301-5-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:50PM -0800, Suren Baghdasaryan wrote:
> Introduce GFP bits enumeration to let compiler track the number of used
> bits (which depends on the config options) instead of hardcoding them.
> That simplifies __GFP_BITS_SHIFT calculation.
> 
> Suggested-by: Petr Tesařík <petr@tesarici.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Yeah, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
