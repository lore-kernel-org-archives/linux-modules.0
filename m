Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C23FE652
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677911; cv=none; b=qmgfMsfLlP3Dg+5vsFXYP9WBEDom0kiq6EhHK1N3Qc8uR+ObbOewXmZuf3j96jx9XBplc1MPeP5P0VIs0gweHK4cLdU4pQTDK4TxgQg1xhw/Cxbxt8ItF72EcAN2RnBAyEimjC73BD3BkBqMccnLqz++dejA78G8Kya8CDuofj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677911; c=relaxed/simple;
	bh=Akkf3kL+PsQe7xmYXgLVaSqFrB61iytAQiQ6WDcfnyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWGPsS0o7bQFqmOzwawpCBlsaN/oG28+n5TRL30xLPKRYa1z39ERJKqOse6WSk+KhVbSlXokoqNgEWtC2MnIo4UYyQJJBxLUPw9PvNAE8zm/RuXnIuOoOqHyr4v8F5yyopI4fnid3Z3j9VYIzSMtXqz8j5xa9E43ThKRDuVSOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bdf96b3faaso235663e0c.2
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 03:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677908; x=1784282708;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4CIBplsIuVz8rQQd1I0ICk9drRx4a3WpiYxfYnZ5Bfk=;
        b=jDL2yf8FJqsMbklC5bWZst5kjAXc6Cyngv3FrjBGEmxrrXb/QINArgc2VxRKJtaqmz
         aPlWJEPYyduWU4wYYoUlko/Ze4JtYD8ERDLC8kiVxo5Y/WvR3/yR2l0b/B6qFWQPPLmJ
         HmEP9A+YBZn4gNS3qDVIjCe1j9Xw7gndxTuZWGdtGbJD3E7U4C9JabgfG2/wyJruM6SN
         zdS7kEy3QRgB+KZhHZE9fOm+PzKoBI/oQHOPsgOt9pBg9626gOawhAkgE3ntG+OGHu7y
         QL5wXaIwB3QhdVo+6rzDsQL/FNpW/DJErdqD2EU0P5BDMg/5k+xElXuFiPVzU7GwIZ4Q
         u4Tg==
X-Forwarded-Encrypted: i=1; AHgh+RrzdndIw4L2K5W7a4J+TCoER8tjpzgY1KAydAwrVf7lzK5ketMWkrndW3eDEf8V1WLcLSuxP72bOqRR9mCg@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKwWQdCsBhs6hkiM2lil9l4bN8Y2ULwjdePdoNCM2qW0Eg27R
	/XFF1QYA70M/FTScBQ08WIJ8GqN1jYh0U5C+/hHUZAzKupTwe4D/Ecppl1W7CReFJpo=
X-Gm-Gg: AfdE7cmAH96G+6pPuvaQSc2VLKzuUhQ2u15g3PqAx+Qg0pvO8oWwRL5x/Je5srkTgTr
	DTGmsU+HKizcSy1FxNQAAvh+UQSiL9ZiJ25rvRuYBgWtpKvGyyGvYB2uZe/aZDxcUHC56ue8LTm
	lv0dCj7AQPWh3u12ZKUxg2pfq5DZ3l3HsIqsXxCh4ShG4/hn2nX2XriFo9YcYn3+Vb4o0vuPspo
	VKpIJbcltY7fL7RAdKynTRi+F+iXCVQ4Egh3QVy6EIg0k/rExVtWM//JH2DMOJKJSBu3iXHKJPI
	zcfjIOsSkrrFIsKeftRPsbU79cculNGqAkr05NddlaEAl/Sk/Vye0I1B8Mru5sIlJlUH3Vu+J/W
	lSqSBldjOo6fW/VJ0/V0z7n6z/FyGK7mRnUnKBNUyfOFz41t/NH71vLVSce73Y69KnZgv5hE+cH
	rNklQddUwZyRwyrL5Oqy1bYvpgccOfQZ61EoQPeze19HmJMK7F7w==
X-Received: by 2002:a05:6122:4b13:b0:5bf:9bd1:791 with SMTP id 71dfb90a1353d-5bf9bd10824mr2754561e0c.1.1783677908557;
        Fri, 10 Jul 2026 03:05:08 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bfa62d4575sm1001183e0c.18.2026.07.10.03.05.08
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:05:08 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-963a722ed59so22144241.1
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 03:05:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrBz5NVFf1cVYOG2gs0RvynacPdkGeJJpizf7wLWMOvFvjt6C4sMMq2m7HSWbsMw1pF4VACyzqOj89E2BBC@vger.kernel.org
X-Received: by 2002:a05:6102:5605:b0:737:d2e8:d644 with SMTP id
 ada2fe7eead31-744e01af814mr5812204137.20.1783677907869; Fri, 10 Jul 2026
 03:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709163833.3851179-1-sashal@kernel.org>
In-Reply-To: <20260709163833.3851179-1-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jul 2026 12:04:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCAX642tSJhvG_Ku6Y=D8GK3owbyed9qkhzPpgrU1kdg@mail.gmail.com>
X-Gm-Features: AUfX_mzFVzbeb8aPhbmCJAceFXYQjpxJuPF0DPyyv44pDz5k7_z7ZhaQ8shBBRI
Message-ID: <CAMuHMdUCAX642tSJhvG_Ku6Y=D8GK3owbyed9qkhzPpgrU1kdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] kallsyms: embed source file:line info in kernel
 stack traces
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Richard Weinberger <richard@nod.at>, Juergen Gross <jgross@suse.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	Vlastimil Babka <vbabka@kernel.org>, Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Thu, 9 Jul 2026 at 18:38, Sasha Levin <sashal@kernel.org> wrote:
> Changes since v6
> ================
>
> - Address Sashiko AI review comments.

What does that mean?
Please list the changes, so reviewers know what to look at.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
