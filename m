Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992C4D5BF
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776074; cv=none; b=RDHVTzwZHQj7qxwOeYDhEG9W41uYwBhy5U5WU0fsSlmwVUey+S4b+B6AQwIq12iwyip7/gt4wqPTCK9FrMETbS0lOlDPN/MiMG7V70TearL+JSxvnoDhbEI38VvVI7jzFWqPBphIoMPzxUzkanTPGSQ7yyaAGrCllVvVx6ouvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776074; c=relaxed/simple;
	bh=h3lvxY7RwFA2qmllpedkHyA1V2cF2YBOaMy0Y3HF4OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHYpgVa1EnALkhmF/pfkLFRYvqgayRKB+RvQEAAkFuTERJygsGW7S8GaWCtRyZRSO9gedONv9u8g9gX/pCQ5ulYRRCVGC0zIUb9riagkq+NiK/4KGABGwLX8IphwPWJF48laSOSlBhLNtSrvzdvzqo2knO5PAKl0s+lSbi/zFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YxoUJYcu; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YxoUJYcu"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29080973530so2678358a91.1
        for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 14:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776072; x=1708380872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIxrgJSE63hrU/LEeVrXgeewq/cIy3PkJ41qNbyzIVA=;
        b=YxoUJYcu2FANQw0aSKgB63e9dtx3sHo+EHRknIB2cIYTMgemXRjmcjc3vir3t5KVad
         aJSH6PYizqDnjHhDSmUnzgZcezvQcONFX3lbBCxSerbvr+MVQLvcBv/2v5X95WYry3et
         lBR/nHNgt84byjcYrbG1aqktz8uUO7dGWXQVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776072; x=1708380872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIxrgJSE63hrU/LEeVrXgeewq/cIy3PkJ41qNbyzIVA=;
        b=CDYQzSVAS9qnHljarr8j4zH60PAYByEfbDf/ze/BNGWzaliZJAm/GZQfLnPzE3+R6m
         3+QuZ4oMmMd1iCqOS3jH4BXMlx65LsfAoGvxe5wIyYRG6YXU2vs9oi13qZRF9tWgTVDN
         Qi+HvjgLa4KARXSRwT/WHCRPvAnRN7FVuhdSnXPJcRpq6urbbEeefnzTb/7JpU3xHOEq
         WxyeEyy88vI6RlEsEfLH0/LaANsV9UZqVxGNSHTCiK3c8r3g5zCBRcLGvXCgDTF3Nskp
         PX+eng+vUzeloeTylWAfb4/qFek7MEY/xthUkJogVzuKjfGPBfcDzL1xz5AcgsoFNoQW
         6JuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLfRC47qFPahZgL2BvVwIbNIuO0SxnO9NqIdXuVBMvNF8Jg1kLTnVsb1fSYG67EZ0RTKTkprt9i7sNcfBjBeq6My11RqseQ0/9tIDMfA==
X-Gm-Message-State: AOJu0YzPMHJYN3aP8VpfOta4Xzay05xwQp8UilVG5uZgpEKWtbM3ALIl
	zizlRzxzOJ7paWMsW9xr6RY5gIWZd/sofTyZGqKwJ6vBtvmK0gZcOlgjhWjQlg==
X-Google-Smtp-Source: AGHT+IFiqvYFTcqWnH4OIf/1Dh8kKaLyS7c6HZ8FWCh2Bts+fuw53yU8/1Sv6ViBQjb2otqFVY6FxA==
X-Received: by 2002:a17:90b:f0a:b0:297:202a:3ba6 with SMTP id br10-20020a17090b0f0a00b00297202a3ba6mr5321895pjb.0.1707776072170;
        Mon, 12 Feb 2024 14:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsNU/8NsDmZt/wglKpjvkWUqHuMmKfr1qDw7hshzseGvRlVn91OWfIWbwPNUldThoFCWHouAaiCcJaR42pa2ZOj+4fu2K/RLpokhW/LHNcfv2bpUoorqtQmMzzcr2uE77OUtmraZBpl3sk2+0JkP3q2aqFPvO8/oCz10/YOwXZph6krxIzkBVwaNb3wv/BrgWTPxyHhkA/nJZtQbzZAwr7loqQ/pCv/14+512lJkj6b5pedTy1UYbPe8fCvkg/xo7qb21F+hs+Z375s58m1Yaqt2RqOXotKP+i3q2TaHpNYX7+Qm1cOW+PXXl0zvf9L5VQfmLrwbCN3rKQhZW/nxd+mxJsLIzrBbjLbMZ0pkF3X38ElFtwskqogWZO17OXKEFqsMjg8CcNd+OrzYfm8i/+GWQ2aoFnvE/VOIsG/Ftpg1X8Xjb9NUgZKHW9NcJAKH9ypNH/EyYK1p4u4VLqY9iriSV6bAxOqn6+QslEU1mHLsLSoMCDXP9iT2o9sZPWgMHL2KdE2sxLxLDrmrAQw82/6vIDTAiOP+gfpX5103QSU+zIn09beoujZ5rXZoEFP2EV4cXNa2fOMDgr7UNTZOyXZY5zdYF8ty4SkdCJI3+tJOtPvCNSgNrNGfOVWTOKs9FTVkNVt8KD/AR23yzqYgL3hH9cLzUNzLgthNx3j8FdaGaJuMjOB+oaxAvuEuwe4ekk5L+mT0ksuIbsY55UWlDcgj1J1Ekfcl8tppAS5UCbJ6oiNYA73Q==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q31-20020a17090a752200b002970cb0c22dsm1120551pjk.49.2024.02.12.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:14:31 -0800 (PST)
Date: Mon, 12 Feb 2024 14:14:31 -0800
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
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 06/35] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
Message-ID: <202402121414.EACBD205@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-7-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-7-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:52PM -0800, Suren Baghdasaryan wrote:
> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
