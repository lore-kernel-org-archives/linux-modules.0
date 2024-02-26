Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B7130E54
	for <linux-modules@vger.kernel.org>; Mon, 26 Feb 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967612; cv=none; b=JfID/m85oGoZeYKst/9tz6P3Wu0HtMKUeuKRnnxmACO2hNQ1SajILQyVBmQQWkglasaosL4c/+GFbqPOHFF3xApFBA1JPLN0hK7YSNYJ3ouEkJzL34no2Km01SQZqNKkrXKod2xtwsBJMqweL1mpZw2rC057KKp6Qex0+jUbRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967612; c=relaxed/simple;
	bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeJRAn6LiJP0y1GurzXmzwVexY/Y4r7PD91HHAUb5AnJVLhQ48rjeDjOdI3fmVS3ONgNczYvfBPThz9EjGEk75TxVTM5rzUY38LcTi4136Po+ILOrslY7sfa8gPz1WEI8rU9q/Vg3G0sG4LSAiXnprSCbe/8tS2qoiu4xRNML2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0fViydWZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fViydWZ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608e3530941so17397197b3.1
        for <linux-modules@vger.kernel.org>; Mon, 26 Feb 2024 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708967609; x=1709572409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
        b=0fViydWZafBwJ3xL0F3ZTuvRSwyOFSrmHfEq0669FdAat5dooHz4w4ydcwe76KJq26
         LLK1Innl8Ozcr4ZzRFS8wOBZXfz8XVvIsM1Lpl41+dDr0LuROfLdG53dNGlA9b9h4eMF
         G1BrAsi2HgrrmZVytsbBCN43zN48wzi+DBMamTdoOdAkkld+5uUZGlksQA++8+kDhnB4
         8YisjaPtufsIlwnzZjkqcK4rgrYZZUtUJ6qGAZVZozShNglx+FJnTn12ouCxp4XPVmkD
         /ODSKBsJ4q/ATs5/nmT5Fa36KV2ZLF/J1cucEBLoNSKhvXKtX5V2YN3O0AKtgJFesZaz
         HUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967609; x=1709572409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
        b=RdAr23crcl+bDtVg+ABET8ZOvPwrbiD/whqKq4VTjwP/TXia5PTBSTVbPWC+A2quHP
         phFPGH0Nvz54Q9/U+m+1SZsqSSOlcQL0rU4ptwb+8N1evYLLRlmAsc4/u/6H5S0vRTvC
         cAg12kkbux2p6brPLVUFpghmLZcBKFK8vC+8tBuJlyr3BTbJH2ZzkxSNS0Wg0Vcgwbjq
         gibx6BTmfhAeuRNzoyK0L8vi95WJWGL9/6a8Y6vjRVIjNA6a1CGudFtPvivCWTPH4XPs
         0jT/YqAkHHmoX2XgmM9D1KxFLTA5OhtKZ4SIIJuBY/tvZk1hZrLnORhpT1TrY6HtRiwu
         DqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcWi4FsMAU21drGEuOxc2ux9Qmjq+vxVdtnh4Meojn9asJTBvklxfnzYVrvzx9X60GP0lZ6DwZDOSVRKcT5JwIhmXPYV0POGte/SErkQ==
X-Gm-Message-State: AOJu0YywyQlbwsGqlbgtVBjdYP1bMogkqWNf9J2HzZNB1zw67GYIISQf
	cDbjhv8mg24hnfGuppyiYeYLlsBp6kE2CM5heewhg2qHodLQwpWvUFJA5YAZ+LNPMSo3qUK/1H/
	neYxOnt1a+0gLSpExkn5AzggEg4cYdGbi+ame
X-Google-Smtp-Source: AGHT+IE/7/pQws6CVfL30UNt1mkliSDpCczaElkub3hA0YpEAm7Kcwht1trOE3ZU3RPvAg7BLiFgI/3lAi1UqBVzgIg=
X-Received: by 2002:a05:6902:210e:b0:dcd:1f17:aaea with SMTP id
 dk14-20020a056902210e00b00dcd1f17aaeamr6639276ybb.26.1708967608014; Mon, 26
 Feb 2024 09:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-14-surenb@google.com>
 <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
In-Reply-To: <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 09:13:17 -0800
Message-ID: <CAJuCfpE6sJa2oHE2HrXAYuMeHd8JWd0deWa062teUs3bBRi2PA@mail.gmail.com>
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not freed
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Skip freeing module's data section if there are non-zero allocation tag=
s
> > because otherwise, once these allocations are freed, the access to thei=
r
> > code tag would cause UAF.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I know that module unloading was never considered really supported etc.
> But should we printk something so the admin knows why it didn't unload, a=
nd
> can go check those outstanding allocations?

Yes, that sounds reasonable. I'll add a pr_warn() in the next version.
Thanks!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
