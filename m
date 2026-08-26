Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51143C069
	for <linux-modules@vger.kernel.org>; Wed, 26 Aug 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764191; cv=none; b=J6c5zfEQL8NuTLfPy3ABg0BfyYLPMHaoA/MrrpK97sWb71CaVqPGuoAAOph7HQXGjXHittqd4O0LXZqv/yEwuktAQ66xH8nh8HaI0XEc+Vk3jGVO9E8l7fsBMIEVW+bvUwDAAzjmXOlVTMHTNRQgFRObPYs8TKjQjLvKa3lpX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764191; c=relaxed/simple;
	bh=HryDV6+5qMbLhZY2KERuGiFp2ZKXAOvyWcXmP57Eq3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbubJplhojU/++6eR1ylahnVJF2mQpgckQorZ7fnQmhh29nHzmWfxxg/b0iKxOX2HkWej8dTlZYi5lGYoqT3fUUhiHo4azD77t6EYfeLS7yyjclWqIZS/7s8F4PaJEQqFmpFzV1gD/wQO9v6wJ5biM+KWqv6eWmY4KuZkkgYfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDZeQKGj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDZeQKGj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso1997815a12.3
        for <linux-modules@vger.kernel.org>; Wed, 26 Aug 2026 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764179; x=1788368979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TJATd1QCK8mzBoL2c8+JxSkXmq9RldTbZrwKcwNjBmk=;
        b=kDZeQKGjuHP6Ge59bPmUk6WLTc+NcJVo2XZ1RnDwli+aHKDJAUteHSksxGVCdR8du1
         bAlX3fA2NcX3AnXBJU7KEwF8QJ82o0afYQ1yoEks10qxCmhjvFJyMRhxUyWrzvpO6Sj4
         e56n85zapKxQLnEDpayB4Oo7O6hkMgnqLhzRvOI04G80GgjzotdM7u+jrApjqOUiDekE
         Sw2qaevbutXor/bcuUNh6UvAQfGa0s64DntC/iy122R2E8qD+Bri8AsE9m8N9GCtjPlL
         X93R02CxR8/3bjmcG4FiYQ3CDYiqIG5ZYYxovOiOxNEKcoITwgL6IdaAjbpsaqtLPPzt
         JmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764179; x=1788368979;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJATd1QCK8mzBoL2c8+JxSkXmq9RldTbZrwKcwNjBmk=;
        b=hoplDR4hUiux7rObY94wDYaB+DqXKDRzeUCeSD1Fwb2FLuFJCtrGf01IaWaLxdCFcf
         U4PXONSaNST8gyBflFEPYUoUANuwcBNm1FXN97ELKtVfUd/d65IzYx7Lx46bAFN1ms2s
         XRIhApZA0eYDaik1ANXJBJZQEBBWEcejqxOZzBJfaJJS8UiJqBob0pJDpcNo6tMcULWm
         bMI2Qikdl1IjrhVURRwohqXmqtTMQyEGdKSFK+JPHJF7lxFAs2D8BJyqG0YystrZLcL3
         vsYW0q0krOL72Z6ekc8CAqT7fdpGAsBIi2qeNapZDoUEQ35CGCHlXypF3iBCgknJwl4s
         mZMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoipapGGIjb50OJmwvprDnP4gAxj8OW8Sk8aTeySrxXbmmVWOpVHiG2fetfPLUXmHEW080Iw971RvhdSPS/@vger.kernel.org
X-Gm-Message-State: AFuF++kYraSGaqpHg5ZAGPjzrQYyHwo9adfwL8lV3zf9wCC2/8E7i5ql
	PZbmwO62Q+X7c31gGX7S7bSmdNhbA08y7JzlOo2iWHQLi7k6YXhYSigh
X-Gm-Gg: AR+sD10RNsGJRs7Tpe710bAClO9fIxxxW4R5Y35Qf4kaCewr+rJ56MAdhFYR7j6uBko
	VXvGWtL0DFbrZYLCgkpqffvcFl54X9L+7Wies6LozrE4+HPQjSZDa4/x3k5Lk4ZJSX16VXygiu2
	r+sldN7u3FNyD3ZYvUED/QiTHd/j949HehJS+11WDCRXJmjPnNcQk6y+/X8xGN0Un0yVXOlMioa
	M4YNcXBPYFWwQ9EgaMMNxBFndu6AnbzUOnqJ3UvwxEU3bxXuy89DPaz/1DVOnVBMEv0BVg0Ogsp
	DR3Fzn40qul6dLaxIwBdRNoyr6+acyLbtt8M7hzsxZBUfdoHW0y6iunwFYuZcObp0Dgl89WnhYA
	x/y3axVZjFp5aGH74ALrAlL7XSkNiYqpd/D0PDQst7hPWwgJuyxPzZSk2ziawm0iY3fkYh6b4Ao
	sTGifuJj0Q25FzjYt8/x8g6kduusav5cFdwcQGz24sQjGkSkqZE5hIFbdHZbnxwFm6fwk=
X-Received: by 2002:a05:6402:a0d9:b0:6a1:f092:3c1e with SMTP id 4fb4d7f45d1cf-6a5df6410cemr9897163a12.13.1787764179194;
        Wed, 26 Aug 2026 10:09:39 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5edef3c26sm2563163a12.17.2026.08.26.10.09.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Aug 2026 10:09:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 19:09:34 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20260826190934.5042b344.michal.pecio@gmail.com>
In-Reply-To: <2026082634-cloak-ambush-3861@gregkh>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
	<20260826153311.6340efcd.michal.pecio@gmail.com>
	<2026082658-statue-census-dc39@gregkh>
	<20260826173549.18c8a89c.michal.pecio@gmail.com>
	<2026082634-cloak-ambush-3861@gregkh>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 17:44:06 +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 26, 2026 at 05:35:49PM +0200, Michal Pecio wrote:
> > You can't bind random drivers to random devices out of the box,
> > you need ID overrides. And then you don't need to bind manually,
> > the kernel will happily select the wrong driver by default.
> > 
> > Authors of the recent xhci and thunderbolt patches admitted that
> > 'driver_override' was involved in both cases.  
> 
> I'll be glad to taint if driver_override is also written to, but it's
> bind() that triggers the actual action happening.  Or so the traces
> show.

Well, I suppose probe() is the first victim to crash in such cases.

But if Syzbot is binding random drivers to random devices, the obvious
solution is to ban 'driver_override'. Using that is just cheating.

If it still manages to crash drivers by binding them to appropriate
devices then I would say it will finally be doing its job right :)

> > Meanwhile, Syzbot also found a stupid write to freed memory in USB
> > core when HCs are unbound. You may say it doesn't matter, but:
> > 
> > * USB HCs are hotpluggable thunderbolt "gadgets" these days  
> 
> We support PCI devices being removed, but that falls under the PCI
> hotplug rules/requirements, right?  Anyway, sure, we can fix those bugs
> when found, but that's not the majority of what we are seeing at the
> moment.  Look at all of the dumb platform drivers that are getting hit
> with this on the syzbot reports...
> 
> > * there were plans to alter this code so that UAF is triggered by
> >   hot removal of the USB device, not its parent HC  
> 
> I don't understand what you mean by this.

There are ideas to change some code to use per-device data instead of
per-HCD data. Coincidentally, Syzbot found that this use races with
freeing the HCD and it would also race with freeing the device, making
the UAF easier to trigger after proposed changes.

I gave it as an example of Syzbot doing something useful with 'unbind'
when it isn't wasting time on driver overrides.

Regards,
Michal
