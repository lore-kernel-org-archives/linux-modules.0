Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD014D131
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775654; cv=none; b=Toj4H8fPU2qo83SsDF3DyF4Kl1NuvUBMtF/4GeU9s58vEYhu9ryhr/NGTCjJUEcoLdvIX7Ik/hLDjZUoKLLhs314EJyvbquv2ZXmLyoYkkW7O31q5/Xd5RtrneOmOQno2uk2q+qJ7u8Qc3+y3/a4gkDOlQ7MA/uZgGJwVFjX65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775654; c=relaxed/simple;
	bh=o3J+H6QK+ft/jI/HQ/DmCribE5VO5VgEVrwjTsOd3+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF6TnhaT4l2sXjsNrnSlh9V3DgV7UmW0gGXUowO9Ck88NLQFZleoMHZaM8E4O4Qafcxb28CjYfpOPXsPD0aSO7Wn64ptxGYY4qwQ9e3tz8mb8LnF0IvZ28r+QSnWbc8PLPBygW3BvamZJzMXsI5p+aOo/EJfDiBqGXaoLJNqABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XdtMu9WI; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XdtMu9WI"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-595aa5b1fe0so2508665eaf.2
        for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707775652; x=1708380452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TgitNbd1mPIu/vo61kw5GTuium5jPqAU8tOs86SzdA=;
        b=XdtMu9WIFB9uc4U8zSKaU7+In/8Xo4bXeWei2q9/eXsCtsC9kPrJ140XpB915ij5CC
         WDYU5SG//GaarAXX6bV/HN1JAUy2rPoEDCzCeVwGRL8evFCYUezqzcft/JPRGyvYjtSj
         Mvkn98lqNGW+hsbHMDsXH9mejpzKBqIQH+/ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775652; x=1708380452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TgitNbd1mPIu/vo61kw5GTuium5jPqAU8tOs86SzdA=;
        b=BKjcHROsyc6gQLdeGpVeuIOj/W9LLolTxlJjdZ7Jet5X26P9RVkiDnTr42SMR3Hbft
         K3x8/4zYT4WZjiJQVW61Nu9tYXFdBBRrhw6wuiDK7US7FC++9Eszp12OYyoR6P4yIdht
         o+KCzkf2jyoBc5ychsWWBVDvueo4kKn0GHMjuCmuuhRvsP9i7TtCLOl6swJdqwLuFUv0
         RPmrmvYY8wEO1QQvA12pTdn6LEasAM7A1cUQzWlEaaCN6AtvhmVMamcOpT9sHhsVF0My
         Bs45tHMOvAzDqHzKGwZai2vHwhVCc83lCq2x4He3sZXPd9dhSQJ/cPuhNBQcM03u6Xuj
         fDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjMhvmDoB/m60b1bQKaH9DRyXCVY5Mxwt5q/dK0YFuEeDKDfRB9fuRcwz33e2oXsdDuqoEbYGRyzXAuPU0cXXQ6c2Qbtw2RKVt1oNvPw==
X-Gm-Message-State: AOJu0YwD28SiIT9QbLds+ea4udTT0iZUDkk1wDCbEIe7RO3eQm77oF/R
	szbVdZAQS45fUjXpojr9xCpMJg7TojXlq3TvFQtAg27Yz1/MN5RRyfOD1ZPpEQ==
X-Google-Smtp-Source: AGHT+IEBoMpvF9BOMExh1vMJk+XNeXjoVJg2+jCy4pHswhoUPY0dich6Z61quUlAHQwa6lLLXH8fXg==
X-Received: by 2002:a05:6358:5620:b0:176:b16a:f392 with SMTP id b32-20020a056358562000b00176b16af392mr12132731rwf.10.1707775652109;
        Mon, 12 Feb 2024 14:07:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8Gn2OxEuKk3FWjwu68UFaXsDD8RjGlM9njWSjabpecNhnMIF1qXxYsfC+/txWlVHC0uNpzndoDwf4ESht85jrpR/r/ZEAKPrZUfbCo36fTMhd5H7f89i82wLKok+ONkyckgWyvxvKZtguOZF19Lc8xEaaVmAhtDm4F98Jh5EiEU3bzhs2RJR7RX0b9EomlrTIMl2Vxf2JdkvMNlJ0310atgxvP0jRcjEz3LHTvUEeurXD9TVukzAeS1b+rDlDTNf71RARiXOdJMocjBhVxo0y425GBYWZy8HcJ3+Ewgj4Xbb5EiVCQj1rNNHF2o6HLhHP4A5G2EKni1Zp8kjTIQjZ7s2fZJ1D72MCwgSyHivTpm6mOTQtfxtt+idhBUM0KbKxWyCg7Fv1qyqxIRjf1NF3si4y72XuPquRerzGB+jFwtjZvokCokPWHXZe7fe9UFmeZqPwFzwdNYmKgzWkpfwmCqyBJbExowRztIrXkyAP1VdjX4X5Qc7dYEOmYc2WTGh3xtGJQr2Xo9EofKKCkp3mJ75b52BYwQbiQKEcmvC9ksvZybPWUZsRvCHQn+/hCuu/sVnHaFqQ2wTv1z7S/eBVKDqADDYHWqcS27arhMV3Qjz5uTY6EdWZHoxUwWBMH6jThkfIXMpBBFqDYg4U/KSoQpNzl38XKZW5h7gL6/YWlncNExg8DDgYF1aMOe7inz7E4L4FD63Iu9G9AHU8reaLM/OMt3uQXOlbrIrQE+z6JttijOLciccsYCwdIBgLeFq6N7Cw2y5pw8g/+8JUMVk=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006e0eece1ca4sm974755pfn.4.2024.02.12.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:07:31 -0800 (PST)
Date: Mon, 12 Feb 2024 14:07:31 -0800
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
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 03/35] fs: Convert alloc_inode_sb() to a macro
Message-ID: <202402121407.A6C61F37AE@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-4-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:49PM -0800, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Yup, getting these all doing direct calls will be nice.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
