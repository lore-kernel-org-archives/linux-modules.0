Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C086AD5
	for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549905; cv=none; b=psWn8vvPNAB7Aoj3L4LicW91+GBrH8ThKyFcsQcTco8s05lAjrXNDG+iVNYdepkFfK+WfGgx7+8G7oNS1A0qbW3UFlY+w4bVakxfJjocboARjVcOWodKynY8J8Knd7qJKm4C2HnQD0rZJL+mRiHygapt18N71RdPKrtJfGi8F7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549905; c=relaxed/simple;
	bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rprGb9kf2k5fXWKekmIBRajjwuuRFe/Qne9BrbM9bBPOp2e7InfTsacqmLGhVyTayQ8aa5i4Qahl1cLDvCkWHJ8w+/VWk1OJWaRVOQHrkyyYa/KDUDR6NsPoObltA8CNH3V1pnGlj9eV1fjhPA3VkwA8U//vpty4ZV6S3vbJi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JqGo42K0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JqGo42K0"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a4516ec46so2062421cf.0
        for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 13:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708549902; x=1709154702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=JqGo42K0IIZzOOrr5BR0MyClkvN7YeDKWCfNCwv/TokZY3MsqLl3j3ldqGJ1DPOTLO
         +ynRcDLGtUomnUMTZ92ie0J+88VL3PPuba2doqpMATUePt69slO+v2jfkeCM/L3caohU
         AeG2b3uqOSss4AobANVRw0xACblRms2znrJNVRRYzWYzlQNntI81UNGjjllb1CbseJO+
         N5i/i8NwBc1feIOuQ2opLu+f0BT+qsc6jM9KE2S1K2qtVlS5Xp/f5v14BZOnLMry7Kn8
         4tDyWcKwiYHiwjWzVgAwB5bfsWEsGCzJrLNPN7Fdp65xZT7Psx1y8sljX3hfAzQWWuk3
         NjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549902; x=1709154702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=e9JEFqZwt7zP2LbpFt0i4zE9KCtCIU5MLzb0zRr8kjZaWl88gK9z0gjuEvvDH7YeG5
         mrgc8+VWCDvzxfD39sj6el2sBtueKwtFxYmwThQSg88wX3czSg7XNd31I0Cw6D3Ul529
         ZGi0wSy8aqd9WCreO+c18xEOUYL9SDdWsVOBSMCSLbl1R+GCQhFSi7GLgbSENoYG7WdO
         n00zF08CvrjHY1JMDbEjTnzFj/sD8OWZIzvda9OHu1lXMXVxVwXtpWj9Ii9Hy6K+3FWL
         cGHiagpubO0jQqKql2XBZE7HrvTj+wHxVrWxLg3IWs5YZaWmlfy1+1YqxOFCyQZzBqQm
         9c7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVszbcjlq8EB3v8IpeS3pww50zSwWnqqOvxdzbFsu8HHZEWKQH6JIeZ7yElMSb+K+JX0iCL6QTaEkYD3PS0ai4K7boctH5pBc4DZkmOmg==
X-Gm-Message-State: AOJu0YxIJkuU31lIJGULJAIdNKv5pQVSRMete2VcTcFpQ/gmKiTHAexm
	cPHY133u2ggRqgmd9sm1Fa9KPydzAy1LY8UOjre2E8c/vF6NsQ2+BQMuIEbpWre7y7k+t9ZfN/A
	C/p7a1v2rrMMFEMSR/PFDGVLzSz2pkqhdLp+CBg==
X-Google-Smtp-Source: AGHT+IEHXmwL8Aza8YxstZPNawifsEoPmvz+hNBFt6a/ALIjCAdVsEQDIakNnjXyrMZE7cImyXSV0z0ORZ0TJZY1zT8=
X-Received: by 2002:a05:622a:1a0c:b0:42e:3f7a:819b with SMTP id
 f12-20020a05622a1a0c00b0042e3f7a819bmr1401231qtb.8.1708549901753; Wed, 21 Feb
 2024 13:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-3-surenb@google.com>
In-Reply-To: <20240221194052.927623-3-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:11:05 -0500
Message-ID: <CA+CK2bAs4t1UhLBahnG9GmFYgW2KxdO7PZkPwD4Wbv7oE+aMhA@mail.gmail.com>
Subject: Re: [PATCH v4 02/36] asm-generic/io.h: Kill vmalloc.h dependency
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Needed to avoid a new circular dependency with the memory allocation
> profiling series.
>
> Naturally, a whole bunch of files needed to include vmalloc.h that were
> previously getting it implicitly.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
