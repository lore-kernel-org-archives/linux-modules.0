Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76072DE1E6
	for <linux-modules@vger.kernel.org>; Thu, 18 Dec 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091143; cv=none; b=dD03yjKEga0CAy4S2X4gHIEPRFvv9gvaDbjlWl8LvhdAtPfnciNqF7hwa91qsG6Qydjc4Y/wVJSJZ/L48GGNZiujwJs6tabdqR+qCtwtHvCGo3f0xZnGCcEcW6rRUIkJr5riFJS7Brq6FHk9LWsQst5GNUD9pritdc0oS0Mu+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091143; c=relaxed/simple;
	bh=HIp67ZJ66WBgktNEozPsyiGDuZDmfpZNOhvVtRqvuB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCaPZLNh5nJhKJ5yfHoTGrE1HHEx0skIjwDvgTNbHOeFiOsFuqB/N8rhfOdwI4CjwDuKlyf0kOXrlxG4dAsUnaZbNonqEjiEJB5PkZqxZYNRKolkhzhieWmDebTPd/8DxzwUIVRXJmN6ZbIGn1PqtKzJQbihYv2WvdiOYwtly/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDEP9YPN; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDEP9YPN"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-644715aad1aso1299761d50.0
        for <linux-modules@vger.kernel.org>; Thu, 18 Dec 2025 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091140; x=1766695940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFDV1spVh/axh1lyx/WAElGBcEI9dw5Gpw/DvU/t3OY=;
        b=TDEP9YPNoBaQMK+0Gp8KKfl9IhvxD4iPyVMRJ7rYRMT2GkcCBHhW7gvM6ePxkvev9G
         oIyY5E3gqY9hUtLBvCcNssKllwlvR6Ykv1Hw2aee29roAMxJF5hWqV/u70tzYulLiTEm
         YK+QBdqfsIx7kWAeVpoK9sMMG8WOa2IyQfPdOpJSmgaI57XYwcRnpG9dHERilTd5HJNk
         BgowG+WIjj7z6I499eB/PfoujjiSdiL9KTQxNNCMxN1Aom75PDuaz7dEoBMuA2UtFujw
         X78NtNZa0Dqj3eRaJTudg5Own1vzFQDSXTpM6MUNNwRIKO8XiPyOYPWg4JgWrsJRsDBE
         kVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091140; x=1766695940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFDV1spVh/axh1lyx/WAElGBcEI9dw5Gpw/DvU/t3OY=;
        b=H/PTjZmx6R6x1EunSYmz2OVAoMvlOnMRWLADDh46uN5ZjYCGc/M3dwgwHLK8DhuHFT
         Mv2G46iJHI88eCYrl7D50xlaCyTABRueo2ImyNjWDXMRb4dW9A0X4oJhGjXJ+6CXVvE8
         6AFLedqN944G34EVXCyTDWV9ZFCbvVna+JCrsIr5oDND+H6jRAtQAqvVpMowGEG0PLsf
         voVQRhsnm7eUw2+h+FoRBI4UYVoadNmgUKxmsWiS12JJodinZQeyRq04PWARf1KgdGZb
         BeQT+SSz3lwlTj27EIvAZMB2riu/iEkG7wgOB0x1SCg+te4m/oSyTAc1+tvKAympmYlt
         +d3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHjHvm1ShUoSaii2SrGmRgBWIMHdyH0EOyst43tRqQfkDxixRm1B4fSB+++3O2DNDXTQU0i0/VB712apGe@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcvI92XQ/XpCpJCu7RXyvUOtPO3IQAB8ZuGHFZ/3Ldn55puEj
	+rs1li6sabKurkQouQGcYgrflRIG30omGADCY3xhWPW8F4b+DHoa1UfN
X-Gm-Gg: AY/fxX5aGsQMBDC+Uw0givs3LK+Y3VkWNi1/xPLpOU95Vw5BWj5S1YGMnDIaOJGUKVH
	JbJn7NL9q0kUNtf0C7XnGjQu6uo5ug7IdxYaYmCYoM07lcm5cUlBvxgB2D5q3BHZfxkA9kjre0a
	F1es2VpYBw/phK2tJxO5k/nNsjuEYn34kT6F/ofGaV2gS+Rw/kZI9yh257OQPFavHkY6uf4/h2Q
	3MD3uEbqkbo60DvYIHSQvdeFPvhm4rAFDw25EBQyrthT45km3ggHDS1AQA6y5y756rYtYQ/3hAz
	+5pT0S6KNHsTHzB6UT1EipUG2lhJp7gfMM0WNpranH+6l9VaE/CVG5VdMkqAUe3nHc1TM10HbJu
	qKBx2nIDZa+5R3q7r+MMeDHxDn0qzCyPSO1syQ5K66js5qZSWLmnGbXxvNi313gxxPbKvfD8b/9
	GAFMTxXQ==
X-Google-Smtp-Source: AGHT+IFKJgg2mFtYeRpAZPfX2mtS+pdy3ddv+t7myY/XFxqvRRKbskRVQyl2Y5hOxjA0iZJLraQFNQ==
X-Received: by 2002:a05:690e:1248:b0:644:5166:3065 with SMTP id 956f58d0204a3-64669d87d09mr709918d50.21.1766091139724;
        Thu, 18 Dec 2025 12:52:19 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:c44b:debe:992d:e6a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f9a42sm1763817b3.29.2025.12.18.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:52:19 -0800 (PST)
Date: Thu, 18 Dec 2025 15:52:18 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aURpgm7csvlGzSoS@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
 <aUN8Hm377C5A0ILX@yury>
 <20251218123349.35339242@gandalf.local.home>
 <95f0c65b-15ff-45db-9845-579f7adf4c86@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f0c65b-15ff-45db-9845-579f7adf4c86@infradead.org>

On Thu, Dec 18, 2025 at 10:34:07AM -0800, Randy Dunlap wrote:
> 
> 
> On 12/18/25 9:33 AM, Steven Rostedt wrote:
> > On Wed, 17 Dec 2025 22:59:33 -0500
> > Yury Norov <yury.norov@gmail.com> wrote:
> > 
> >> I deem to drop trace_printk.h from kernel.h - it is more aligned with
> >> the idea of unloading the header. The original motivation to keep
> >> trace_printk.h in kernel.h was just because a similar printk.h is living
> >> there. But after all, this is a purely debugging header, so no need for
> >> almost every C file to bear debugging stuff.
> > 
> > It is a big deal for debugging stuff. A lot of developers debug their code
> > with trace_printk(), and do the "shotgun approach", where they cut and
> > paste trace_printk()s all over their code in several files. Having to now add:
> > 
> >   #include <linux/trace_printk.h>
> > 
> > whenever a trace_printk() is added is going to be a big PITA and slow down
> > all debugging efforts.
> 
> Eh? Maybe a PITA, but surely not a big one.
> Slow down "all debugging efforts?"
> Please cut down on the hyperbole.

For me, removing trace_prink.h saves 1.5-2% of compile time:

Before:                         
#1 real	5m12.602s               
#2 real	5m11.333s               

After:
#1 real	5m6.190s
#2 real	5m7.151s

I'm building ubuntu-derived localyesconfig with a couple extra drivers.
Steven, if you're not absolutely against, lets drop the trace_printk.h?

Thanks,
Yury
