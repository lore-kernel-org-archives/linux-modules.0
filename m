Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9714264F
	for <linux-modules@vger.kernel.org>; Tue, 12 Mar 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273431; cv=none; b=E5FpCT71PTJxQ0VAUop700uYS4uvsFHdjozqRbkAc2Wg36l7qipkR5F4CbU9gM9Sw61r3UOheIcOQVclQfcd/6R/iQ7VpXoOEulVVD5kTzZszS9yaYihrqtPfwa9uKm6HZ1lBCa9H8p0ENMsi4AzIw1bx+cAC0Yzf9hjRMeGHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273431; c=relaxed/simple;
	bh=0aWGvxVmbgp4kFphrT5DgrMJEPHTfdbj9FAM43oX9JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCXbmmHJBTQXbwndShUxvw3G4P7RWDi74ut+/JKclantp9TtU9tja05xW0JOw8+OMa65q0rd8rYG3Ls/QJjPciWqJPCk8oqMZj5Wuveu4Cde7mPJRMNjh/0chJuWqrNvSf70pC9zkuqAOeJfrHI9c/oXLEzApEvI1685DRKD5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9SkdvBC; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9SkdvBC"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6098a20ab22so3034617b3.2
        for <linux-modules@vger.kernel.org>; Tue, 12 Mar 2024 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710273428; x=1710878228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT+2mjCDEB2wrTUTyTKLuab+xNoniRJZtNtidsDDPI8=;
        b=n9SkdvBCP29jpiwunTx9H1BR2Ml5UNn8v5otShFLYbK7JyH9MubPTv36E75no1LqDL
         F087Nx5gd76hBnyWnz1RKILaph74iezHR8dfxhvrNyu4hW+OvUANcVGR85oF6szeI66p
         LehTfrQIsekB3y0zSlUlFw+k4rC27MANhiDGq5MWUDj0v7p8X/r6xuB6IfOk+yaiotpi
         6PNsdZ7oDH/REX+V59tRksPbBVobOBRxA5gTKm3fkVWKTVvVvhW6qkyHeDff6HIEDksZ
         NyymvyrhhQDYaBGvJfqmaPS8cnXSuEknUF0Um/xxxhDbr2bvMvHMcAwmZuBE64EiPD4M
         sflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273428; x=1710878228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT+2mjCDEB2wrTUTyTKLuab+xNoniRJZtNtidsDDPI8=;
        b=a1z7Al3+JvS126rnjYwOpTJ+g8mYe1VvDelOeXVV/Ao17hNcUfzL9ZKgjXWwDa/C00
         zc3mSRUyC9RBjVhBzffuUm0gmSZNFmAG1C+lbv3j7L2UVkIP9hIBEWnzZLwNRvyiCjwp
         Rz+cRIYH0JO3n/22SyvipHK8+eW1jS01xcwXbyHanesbl1BpkQjPeq5yTwVDqhip5/AK
         fgAszn8sw0xCBZG9BSYHpk43hWChR/hUYZCmhPjssI6Z2cpgX8aPyi/r6cnmN4dWa9f7
         88q+kY1xccH9Zfj8WQ+OouHOUEy2xeVWJO0U5+G3HIo/Pjgcs29vW65iqiDHMIlMuSlN
         ZcXA==
X-Forwarded-Encrypted: i=1; AJvYcCUEuZ1hzFsFN29FitRUyEvcj4nY+rzo9/ZrEuTz782n/dBVDOPwkPsreYS6rpbHQaR6m4Nr1VE26+9fQqs3o6PMPlHCMWEiWF+DosBVSQ==
X-Gm-Message-State: AOJu0Yzk/hthxWSXS4zi2g3JHv0zwf6XzNEGHyWLovgwXgjfNRBhrpPC
	+JskReVqPwR9PgPuVZ44RIOwYrzqDJVCFs/XU98b8vITxMut0N85ire1w4Ad5sThct2njY/kJgt
	Udbca0tIrVnQt7Gvl4zuM7UpYjSs8psQ5U3EV
X-Google-Smtp-Source: AGHT+IFrpwFQf6DsD+MDcouIBUBxz7xm6ZVbTg/EsBFYmgBgqnN4d7DhlPhedvQ2z/xYUtX9OCTiPw5W4WvHfMsUOCA=
X-Received: by 2002:a0d:e885:0:b0:60a:67fb:146 with SMTP id
 r127-20020a0de885000000b0060a67fb0146mr551414ywe.17.1710273427660; Tue, 12
 Mar 2024 12:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-14-surenb@google.com>
 <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz> <ZfCdsbPgiARPHUkw@bombadil.infradead.org>
In-Reply-To: <ZfCdsbPgiARPHUkw@bombadil.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Mar 2024 12:56:54 -0700
Message-ID: <CAJuCfpErSnRK3TH-+keVF+2Vq-e1cSXrOcg8UAFke3btt2Y9+w@mail.gmail.com>
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not freed
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, masahiroy@kernel.org, 
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

On Tue, Mar 12, 2024 at 11:23=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Mon, Feb 26, 2024 at 05:58:40PM +0100, Vlastimil Babka wrote:
> > On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > > Skip freeing module's data section if there are non-zero allocation t=
ags
> > > because otherwise, once these allocations are freed, the access to th=
eir
> > > code tag would cause UAF.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > I know that module unloading was never considered really supported etc.
>
> If its not supported then we should not have it on modules. Module
> loading and unloading should just work, otherwise then this should not
> work with modules and leave them in a zombie state.

I replied on the v5 thread here:
https://lore.kernel.org/all/20240306182440.2003814-13-surenb@google.com/
. Let's continue the discussion in that thread. Thanks!

>
>   Luis
