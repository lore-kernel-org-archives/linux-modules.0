Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5103A75A7
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546487; cv=none; b=Y9XpDH8lmweUMhMHdjy3zNxpxyFt7S95MxbMzYesW4epfqTr13SRN9u78aB8m9oig0CVbi0rVvN1ywanVxdZdV7nnAJfyNxDc9XdW+3e9PdTrNUflM+EOt6j6qfKygBB6TQBk+d0DmkrJ9Hp5SjhGaG5TZIOStmSL90iqy8zKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546487; c=relaxed/simple;
	bh=QLj/GX5k7eFyGfeZf3Wtm2oB8X6vtQ/bwHDCPYzJK1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHhylxt6JSZyypFJqO5k4n+aLyNDYPNPamLg0cO5mIwPy35JoxtvEdqq7XusuSMESANjR4tvZ5fC7jW3yv+RqZdq2bTRMz4Tj/YWWXrNTNcpiqyEaJGWoQ+n7LTynLUBkG/pokB/ef6+g/Q0ZubUFRWwfJmm6B/wikrdjffKoEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-672bd8e06a5so1047662a12.1
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546484; x=1780151284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuWEfTQYjsCVqVvHObEiNmRNaaJS3/KGoVEjCdjn4Xk=;
        b=dxuDzRkjCtJMdbLmOBIpmFP49JYKXFO5na9Ufik8qAUgTD4zCund9mGcYPX+SfG7i9
         MtB4zi6bofK+r1PNO7CFIAJwCYenwWs8lw65viqDBL9DZitG0doNticC+botFmGVr0Zl
         5Ik82ZIPBDWOQ92LjOUub75zfeo5HelWLLxX9m9HOFJV7kf9nn3JH0SFZOLETeQAbefa
         8KXmiyKQiIW8UNtM0jfNKmOz2U4SYHVSGVIO1vn9KHEiqUo5HzBRxRNw9uKXawy5SCky
         qoKBUJLgAY1uVEUEWo9dyn6LqM8NHzsp4GA6q8hT4wA73zqsPRgZGGR0hAOaukhJyU5X
         XS4Q==
X-Forwarded-Encrypted: i=1; AFNElJ95Bfs7CckM05m94PKXirrIELrMGCMaV7JTdTxXaivxdXqLq7wlhDyoN6Gg1ikM9T4lQjctmVUd1X/2iBDU@vger.kernel.org
X-Gm-Message-State: AOJu0YyLo5jlZa2SU/yRfM91HYYOjGC6y6sIhIcvPN/9qIhuc5l6T/qp
	0Op+wgv1z/69b0zJ4EUQcCsKdgTFaJVIgB3dFGItQOyiAZ3BubdwyeivxOlGCS7DtYM=
X-Gm-Gg: Acq92OFI85g9Q64nvrRPmzbj9Scc9PGeypAY39dQh5su8Wg8wDMxK8UwRFqc45Z0UIi
	YcfvJMtDtQisjneQKqVxz8XGzAF1ZyzGQSPdfD9NAVDpo+LnuBm0+4pCkgusIY32Bei09ctZS20
	I494xelaZkwiAWcnGVbegRoY+VDE43ao7t+BJv1bVKWkUYhko4bsYHBabYeWUv2QtHVdVXadEBe
	djR8H5qDa3yV7F38Yg6GZHQhE9jB58uYBQJ9BMgLdqAFhg9CJ9DDTww81XCRU+5b0Im+fVvYOfO
	naGZOE0JpiXS/ZPHthGpeOnT2f8P2eiMbNjgjprhf2VUEO+JawV5qBSZ1eIHniNa5daAQ4HkBCe
	SVym0bD2cwZsHPoMrXMyaayincz6mUxOvTdnryvoW4yN7tl6H6U6eZ5kunMECyj0icHRRK5EbZu
	sdHcvBzSUTWCLTFXiSnwFIN/80uuecOcs1QELXkU3GKYaorz4mzbJiv0+TYBR1xz8T0nK+JP0jZ
	HfMqHkJBMFygp5kCtOnCcwdQ40rMrhTAZ7hcVz4JHeX+Yk9d72V4ljHUPLhDM3MBoaUQ35CU0z1
	VmwzGsaU8Q==
X-Received: by 2002:a05:6402:458e:b0:66f:9021:af19 with SMTP id 4fb4d7f45d1cf-6889ca475cdmr1457772a12.4.1779546483839;
        Sat, 23 May 2026 07:28:03 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1eba4sm2020785a12.18.2026.05.23.07.28.02
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 07:28:03 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-452aacde862so669066f8f.0
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:28:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tdRGMtGmb1aCWghE8r3TuCQpMXR/ayOqo540xpB8bRhQvrvxhHT66jWRtGMvtPIWFHxSwGaAg/NelU9O2@vger.kernel.org
X-Received: by 2002:a05:600c:8484:b0:48a:56d4:7274 with SMTP id
 5b1f17b1804b1-490428ce814mr56748215e9.3.1779544847387; Sat, 23 May 2026
 07:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205071855.72743-1-byungchul@sk.com> <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
In-Reply-To: <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
From: Yunseong Kim <ysk@kzalloc.com>
Date: Sat, 23 May 2026 16:00:36 +0200
X-Gmail-Original-Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
X-Gm-Features: AVHnY4Jzdbo-RS-M3p-EbMJdQhZ_EyUwot0ge9SpoXayUSqjrmRfCiJZJ7yo4J8
Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
Subject: Re: DEPT (the dependency tracker) as AI review prompt? (was: DEPT v18)
To: Harry Yoo <harry@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org, 
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, 
	dennis@kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	vbabka@suse.cz, ngupta@vflare.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org, 
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net, bagasdotme@gmail.com, 
	wsa+renesas@sang-engineering.com, dave.hansen@intel.com, geert@linux-m68k.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	Chris Mason <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Josef Bacik <josef@toxicpanda.com>, Yunseong Kim <yunseong.kim@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harry,

On Sat, May 23, 2026 at 2:33=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
> Can we start DEPT as an AI review prompt, by documenting DEPT's
> dependency tracking model and false positive elimination rules as a
> carefully crafted prompt?
>
> While DEPT can identify deadlock issues beyond lockdep's capabilities,
> it is hard to enable in automated testing; without fine-grained
> annotations it can produce a high rate of false positives, and verifying
> them requires significant human effort.
>
> The open source AI Review Prompt has locking.md file [1] that teaches
> the AI how to review locks and detect misuse.
>
> If we can write a review prompt for DEPT in a similar manner and have
> the AI do the deadlock detection and false positive elimination, I think
> we could identify those problems more effectively with much less human
> effort.
>
> [1]
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/lock=
ing.md
>
> --
> Cheers,
> Harry / Hyeonggon

I think this is an excellent idea, Harry.

I've previously experimented with running DEPT alongside syzkaller fuzzing,
and many hung tasks missed by lockdep are caught by DEPT, but the resulting
high volume of reports makes it easy for issues to get lost in the massive
log output. Sorting through that output manually is a huge bottleneck, so
leveraging a well-crafted AI prompt to triage the warnings and filter out
the false positives would be incredibly valuable.

Leveraging an AI prompt to triage these warnings would be incredibly valuab=
le.
I'd be happy to help translate DEPT's tracking model into specific rules fo=
r
reducing false positives and establishing solid filtering patterns.

> On 12/5/25 4:18 PM, Byungchul Park wrote:
> > I'm happy to see that DEPT reported real problems in practice:
> >
> >     https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I=
-love.SAKURA.ne.jp/
> >     https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byun=
gchul.park@lge.com/
> >     https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@ig=
alia.com/
> >
> > I=E2=80=99ve added documentation describing DEPT =E2=80=94 this should =
help you
> > understand what DEPT is and how it works.  You can use DEPT simply by
> > enabling CONFIG_DEPT and checking dmesg at runtime.
> > ---
> >
> > Hi Linus and folks,
> >
> > I=E2=80=99ve been developing a tool to detect deadlock possibilities by=
 tracking
> > waits/events =E2=80=94 rather than lock acquisition order =E2=80=94 to =
cover all the
> > synchronization mechanisms.  To summarize the design rationale, startin=
g
> > from the problem statement, through analysis, to the solution:
> >
> >     CURRENT STATUS
> >     --------------
> >     Lockdep tracks lock acquisition order to identify deadlock conditio=
ns.
> >     Additionally, it tracks IRQ state changes =E2=80=94 via {en,dis}abl=
e =E2=80=94 to
> >     detect cases where locks are acquired unintentionally during
> >     interrupt handling.
> >
> >     PROBLEM
> >     -------
> >     Waits and their associated events that are never reachable can
> >     eventually lead to deadlocks.  However, since Lockdep focuses solel=
y
> >     on lock acquisition order, it has inherent limitations when handlin=
g
> >     waits and events.
> >
> >     Moreover, by tracking only lock acquisition order, Lockdep cannot
> >     properly handle read locks or cross-event scenarios =E2=80=94 such =
as
> >     wait_for_completion() and complete() =E2=80=94 making it increasing=
ly
> >     inadequate as a general-purpose deadlock detection tool.
> >
> >     SOLUTION
> >     --------
> >     Once again, waits and their associated events that are never
> >     reachable can eventually lead to deadlocks.  The new solution, DEPT=
,
> >     focuses directly on waits and events.  DEPT monitors waits and even=
ts,
> >     and reports them when any become unreachable.
> >
> > DEPT provides:
> >
> >     * Correct handling of read locks.
> >     * Support for general waits and events.
> >     * Continuous operation, even after multiple reports.
> >     * Simple, intuitive annotation APIs.
> >
> > There are still false positives, and some are already being worked on
> > for suppression.  Especially splitting the folio class into several
> > appropriate classes e.g. block device mapping class and regular file
> > mapping class, is currently under active development by me and Yeoreum
> > Yun.
> >> Anyway, these efforts will need to continue for a while, as we=E2=80=
=99ve seen
> > with lockdep over two decades.  DEPT is tagged as EXPERIMENTAL in
> > Kconfig =E2=80=94 meaning it=E2=80=99s not yet suitable for use as an a=
utomation tool.
> >
> > However, for those who are interested in using DEPT to analyze complex
> > synchronization patterns and extract dependency insights, DEPT would be
> > a great tool for the purpose.

Best regards,
Yunseong
