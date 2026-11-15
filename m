Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752676;
	b=kAtIsZ6WF6WD2SvCAAEFOif3DDWyP4biYmd+sKamSIOBOY/rQTuBWkXxhQ2a/3116qoO
	 GDhDUgU766qqkuneHbS8HECL0t2G0Vmq+L1VLdAb2mW7sO7Q22DWDPzfM1Gw4+3G18ktK
	 XMUVB//f8sO9yEjcFypqZZFF7zithBqoUeWqIloergEi15qsz+RwCRdJ0xwdkc8KKrHoB
	 vfWJQu5QmsG5Pg7PsqBdVWqIHF8rLD6iNPO/ZE94Bo55DEs776F4pK9UmUx4Yx7siEzSg
	 j5qFA2K3lpuB7/jld3xmbtyWiYoF//oHbmnb762qeAB3Hs31HThklMYFM9O72u2/bhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
	b=yiwsztOn47Cp++9cbRO9gO+Q2SfdkbrVOydRLSI70zOwBJGlXzXamRQGY+Ar4llme4fl
	 UFBEa9i9Ja5GSYKjhFVCkHzLnY7cT68hlDwyi/U2ziOKVN2ba9jeB1TvvrF6hN50uMoFe
	 O4okOYH3+Z+AWDPIFVDd/5mYRzYvZrEK0qQupFH8RJpL7ZfmnUC3YD0tWnGO7c65a9lkx
	 bqJPxnuwmoFbgNg3kN6nfZbIbOb1cw1kL6646qtbV5tvPtndPvHgF94oTmEpIIhSflVXH
	 AmcfkwVxBuEC+Q7mqNHJKlGDJ6Z6PMrAiKDDaVX/R/KlkoCw8CoAUbbhFhACAPyqXPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxVes4fN;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92674606A338
	for <linux-modules@vger.kernel.org>; Sun, 15 Nov 2026 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92674606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxVes4fN
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a210470b49so20251655e9.2
        for <linux-modules@vger.kernel.org>; Sun, 15 Nov 2026 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794752674; x=1795357474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
        b=jxVes4fNS9TSgGvlHsTT80+9II9XinvC4prossPItwxQmdIh/ly0jdC/cdyT55vVR6
         dxr87FlrY8HaEzKWL1k6AkuqQTejZzqNuP03IkWn/1QKMcHCGusJm7Uzh90VmKNatLHN
         /Ur+ln5v7C1S9XPfNu7fKUrI1pDdBwtHp9o72Tv8ddrZYc02/UP04z5Cj9qKvnMUiuBc
         AKlR1i85YUHuEqLhR+nPnOGxB8gyhi3BmtQiXq42P2XoLdScRFWDqb++9b0P9t/EHP1y
         PjbWv5kEkbF943EnXhorY4a6wJ2J69Bqn/WcjcubzUA5IRKt9NLekdoBKWqKwl/hWu6c
         NQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794752674; x=1795357474;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
        b=u5fnRw47ZVv2hmkS2lOSCk/nzCWAcbIXga1zglXXWVMqSBa6tZZhVoLtwep6xZjmxK
         eSWnkGxMt+Thbvej13SeSdYMurZojcsiK+MZWTE0GPA4nwKzYhznoKDBUDI+LIBL4miE
         P3wShd2bcq3U494Q+13+bMrhXsixfOcejfkMCLZfxtdOg37vcXicDyilkiRj4oI1nMkt
         nhBBemVDXapn7yCOlRQGdZrlK/lo+gZp63AZE9UDxd2UOlanfxarFJUvjvpfDbEab41X
         vhAAfk5IeS7MkUudN8lKRp1ycy88Lun/dRbQ2U4QOrIidhygP4LwRFzRz+NfyC6VZnje
         f++w==
X-Forwarded-Encrypted: i=1; AL+hErES7o+Q+PvdGLZ85BvfjPAJ9gnJ9Zu30l/SpA+U6QEkBp+G8VwBPnw83+OC79/2aGfji+u+Pa+nFhk61rvY@vger.kernel.org
X-Gm-Message-State: APuU4Z+bG/y4eRVMpNbdOVBMZGCqRAlE6/K3vh1d7ykpr/UafmTjtwmF
	WIUrMZjbRHgy89nMWf7hLZeCBpUpRuq5hX7cEOqZWTKXz41X39D4Hu4h
X-Gm-Gg: AYBFou0mrZFkMveE/+1k5H/SxJi4M0+qT/NN59rYvd73q6RVQwefd6OG+wglSKwOm2I
	NI9T2NWmpkon6J4oKlBG3Q4rpf3iby/WZox7qYNvbIAIlTiF3QTtlAm0UzjdToBy9ZTWi1RmmFv
	QERPuMsBAj25HSQe311qXQs5/3F6zyevQWFVNwIlCWvMflnZys5tSlvK60yBvbo5uCBq+vP/wOS
	mQCGB9RDODWi+UpfGOywiIpbb3YJeWCNvLcvfVu/+s1hQDxO7uicyw5B1c0GMu4wNxILRDoFt7M
	hX1RRY2ZvHMGMzfTqlPqLk0afUXUaLich8C/Ipb24uJ3rq3DAI9E/3sdcXwUmoUGAYkCBSOsbav
	KmneuYMdzWPcnWpv3uOmSo1a2BwN8F1OCtBlu18ZBkd3uItyCGdWC3SRoFAJkLamb2ItIt32F3M
	xKO3LMhdslTB5C/6FZyAUEdpANaQESGmqp3ecp+zK8v/IEO0aLz5r7tbfFRuju6ZM3BTMLvP8Uh
	FOOKMLE9zXQUIdpD21T29ZW8sjX/4pwLqmBt0aJc7IJZU5uB0znMRKvSQAglC/tr94w5t5O0Enb
	Mle1CD1MnZ55NGVAm5mAo4s9xG3uE58gACG6ILVuOP2qX3vQxIa51P4tVtwQ7x5d8X7rdy5qk/V
	RDkAKjJr2Kj8=
X-Received: by 2002:a05:600c:c0c5:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4bb55a6602amr130912825e9.9.1794752673813;
        Sun, 15 Nov 2026 06:24:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm318854915e9.15.2026.11.15.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:24:33 -0800 (PST)
Date: Sun, 15 Nov 2026 14:24:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 and KALLSYMS_QUERY_BY_ADDR ioctls
Message-ID: <20261115142431.1587690a@pumpkin>
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 14:12:45 -0800
Samuel Wu <wusamuel@google.com> wrote:

> /proc/kallsyms is the primary interface for userspace to query the kernel
> symbol table. However, resolving even a handful of symbols or addresses
> requires reading and parsing the entire text file, which is often several
> megabytes and takes thousands of read() syscalls.

Separate from this, I've wondered about separating out the /proc/kallsyms
code from the code that actually handles the symbol table itself.
The two parts are pretty much separate.
IIRC it uses a static function to get the symbol type (which does most
of the work of getting the name - which it also wants) so it isn't
completely trivial.

I'm pretty sure all (well almost all) the changes will be lower down
the file than my changes and won't cause (hard) conflicts.

I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
in userspace for testing both, but had to cut the bottom off kallsyms.c
to get it to compile with a sane number of definitions.

David
