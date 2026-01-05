Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BA30AD13
	for <linux-modules@vger.kernel.org>; Mon,  5 Jan 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636455; cv=none; b=gGP7FKiyX22c+rqHl3c0mT1qEmy2KeTcjdIJJ6eDq2XTf17xJaHLt7IRXfmChyMbC8rRJXjVEZwpy5BUQfvdsZTeFMzH+N5ej47XQy9LUMVQ+34pf06G+PZqdnVKT0XshjEn4ct8JSN/zExcYMY+PKaMJ9/PtJSs9nHvjUde6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636455; c=relaxed/simple;
	bh=xN/1Y2imSakEK2lDSZcBhgYB7FSZM1ffg6Nf3YT7Z+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLgHhCfZ8o2BoeCUxuL6M/grLi+5k4FRSwFlQ0Sv/qOLNnPu+EViqAN7dr0264ICY4Nw2fcjHzYLoZCoGCZWuEZoKLEDf1q6p7J7QMcuIf0c5O/lMJrktpgHNU40I2JrFpEzNRA97Y0NTImU9eF64HYzoIaLc7eo9dS3cOzFwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ2G34PT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ2G34PT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fb5764382so2846927b3.0
        for <linux-modules@vger.kernel.org>; Mon, 05 Jan 2026 10:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767636453; x=1768241253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5/uW9/0KwBsgtvUptXheatwXpOA/HjQmX9wHy8TmRk=;
        b=nJ2G34PT8d2ZUg5NUhI2HmtRSAKxk+1R431kxJ9iawAS4AnLbEAMcnVqcyfw0s6YNF
         o9QDsDxa09AaeqWfgA4GXbqOtwY9N5DnNFyWpdom9Hy/UWbyRe6go6gcxQRpXSlLLthH
         v9zCEZbqGbu1Hwfsy66b+SOLQi1v9hcSWhk43zhL/VYr1ZGrkp7g7HX8nNcNFJZuXrjv
         KeeQlC4rmnq+eIQgoSMBe+I0hajXF+fXRzuAf1vCFNJYenJSMaIG4V6s/TE1KONol1vU
         4oZdwwGX6vl0fmxbnGIgMIS5KRyUfzKx2YEtbWLLU8FU8TN4BWh3eCYDEI1oh8q4LTfP
         3uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636453; x=1768241253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5/uW9/0KwBsgtvUptXheatwXpOA/HjQmX9wHy8TmRk=;
        b=L6M94/Y/ZaqnhkCl2n2mtUF9t4acEnL1rHbzrq1IoIn79kkFRyevbx2SlP58cFU2Wb
         HjN/+YiLv9EfjYis7ywPl8lB4jqf+dhei9FFqf31xmhnFM6EWu9oDY8TKAf7HSfptGPN
         +lAgNowwoj+LNSCuRzX022yITKbZLw2PYXxBLP9c5J7sC1dyaeb8cBFa/MiX2TxJ30iH
         G9C92wgLS0ke9BA/X4845fcA51tzftngG3gRu272XCoWFaSQFu3F1AbMdfXttJ2BZOOO
         pBx+662GL2o4b8hflD0BtORWTpOHCfMacyqy1+y/htqKjQyI4cctIDmiTHU+Ncm7NNzY
         XoTg==
X-Forwarded-Encrypted: i=1; AJvYcCVFCtedF0ZtHPioFEK1ilpiYMwMzBCNxFy9j1Cm/tK+87Vw5jcPMBvRtp6FgtRNG+wNRT6yCCW3Tv6CYJR1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/PVdbFRLUEndKOOCSxk6hxS9ANhFBknB8Wrz2oU+83iCHFIw
	2V7r4izzvxfiRFjO1pLFR8AAV38bG1S7aGORP9nYmsSkHS0yq8oknAs/
X-Gm-Gg: AY/fxX6lt3Md42VTxh8/jU+tGHqCP81kngLIpAsDB1QXjjxHRDV3ku3F0U7L4qm54Xv
	TFF56eJ9/DnsjTkz52ENl9MGhih1Cu7VRHw4/cm5Q/PvxXyZPBItfBPbwDl5Kxw9MLawA88urth
	9gSRhQu1GfbK6QPVnDNZEi3RRCTnICEPzmq+V0ZtvxKmf+NhfwbgEitvkmTE/mS2Y0RFNZk075/
	+hM8TiSkVLLVvGhU9ia5Sx5WWEFfm9L/gPXnokns37YYfo5nUkazc9vZP+S0d4aBsp6D9lvfotC
	NUaUt+WX4CvtgtAV5J8qcU9IqMnjaDwMu3zXlqzv9C5uNa+7isPXO2DNTpVaRWDI9eo+WqZqr7K
	uFTg0sIOMVCJCOhxnXw9NqPCPIpbt6W+I9J5DRONHBVIxkaOqBE+wIJRLAT6DyUX+PPK0a5VxnP
	UuHCachX8=
X-Google-Smtp-Source: AGHT+IESx6I8tg0gbPIh4EuMQXlx4iATZY/+u860W1pgMc/DuCthIaOeJmHqd9Ob5cc2d8ol9SaLZQ==
X-Received: by 2002:a05:690c:30f:b0:78d:6a71:76c5 with SMTP id 00721157ae682-790a8a8fd73mr3709847b3.10.1767636452758;
        Mon, 05 Jan 2026 10:07:32 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:830c:9f83:df41:3e7d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790a87e1895sm1457087b3.18.2026.01.05.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:07:32 -0800 (PST)
Date: Mon, 5 Jan 2026 13:07:31 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Vivi Rodrigo <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aVv946dXQfOifz5O@yury>
References: <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2>
 <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
 <aVmyZ0iXzTkNU86y@smile.fi.intel.com>
 <20260105113902.6bdfcfa8@gandalf.local.home>
 <aVv8vwtGFhssitxG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVv8vwtGFhssitxG@smile.fi.intel.com>

On Mon, Jan 05, 2026 at 08:02:39PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 05, 2026 at 11:39:02AM -0500, Steven Rostedt wrote:
> > On Sun, 4 Jan 2026 02:20:55 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > > I do not think it is necessary to move it.  
> > > 
> > > I'm not talking about move, I'm talking about the C 101 thingy. Any custom API
> > > should be included before use, otherwise compiler won't see it. Which header do
> > > you want to include to have this API being provided? Note, it's really bad
> > > situation right now with the header to be included implicitly via non-obvious
> > > or obscure path. The discussion moved as far as I see it towards the finding a
> > > good place for the trace_printk.h.
> > 
> > It's not a normal API. It's for debugging the kernel. Thus it should be
> > available everywhere without having to add a header. Hence, the best place
> > to include trace_printk.h, is in kernel.h.
> 
> With the above it sounds like you rather want to see it being included as
> kconfig.h (to every single file). But I disagree on that approach, why do
> we need this header to pollute every file even if I do not debug the thing?
> 
> But since the current state is kernel.h, the status quo is to keep it there
> for now.
> 
> > I'm thinking that my proposed config option is the best solution now. For
> > those that do not care about debugging the kernel, you enable the
> > "HIDE_TRACE_PRINTK" config so that your builds will be "quicker". But for
> > everyone else, it will not slow down their workflow when they need to debug
> > code.
> 
> Maybe, to keep a status quo.

+1

> Seems for now the compromise is to have it split and be included back to
> kernel.h and later we can decide if the option or other variants can give a
> better granularity for people who are not lazy to remember and add a header if
> they need to debug stuff.
> 
> Yury, I think in v5 you need to drop this patch, otherwise we won't move further.

Not sure we need v5 because the only change is dropping the last patch
in the series. But if you prefer - I can send v5.


