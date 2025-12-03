Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD321398F8F
	for <linux-modules@vger.kernel.org>; Wed,  3 Dec 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781948; cv=none; b=QzLUYaUOf547+X0S7QkOQ/A/fGwzc0H9I4m1SymTpOWgH55rjgtkme0Da8B80E0vVqarXYZ5TWjuGLCuMxDzp/ZwXCAi7WGLiUd8n3fQcgbU9Xu3/+zv2EUkFB5w4ANJrPbOrDJ4P4eEpfbT9qvvJlmF3kYYxEZOJHDCDF/LEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781948; c=relaxed/simple;
	bh=MCXpOHHpeG6Bm1ZLgAakALfHlHZc/OxDqj57EFCGIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU2MQjY13rvOb+O9ilxEXZsjMgfmUugMkCCKoEjufRi/rvFMf4ojVi8m/PPBkhh7VAqEiN8wZUbn0cMtpNc32WfF2SppzRxssSQyatfNSZE/RaZ1LXkdAxOnytw7g49X/6N/Xnb1gF+HBwMOUowGVhIWVVHdSYPSwQo71faHoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai58hPyg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai58hPyg"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a76afeff6so145187b3.0
        for <linux-modules@vger.kernel.org>; Wed, 03 Dec 2025 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764781946; x=1765386746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dMlhUa22KWJ2ilQ42UhqcCRS5uDTPNIwpYqFYW9E1I=;
        b=Ai58hPygDxhbfWKDeh5VKKyscX/dOVaSFbwol9eEEH/wRu3CqB87sdI7QhcMTMS/ak
         64F04bk6we8TqMEh6GbsU9aApXIuzosvs9M0FPtEcrmDF3iNvaEo8t3/j/G91Sy2g2A8
         jpEr7/b2LPqQ9+1V1wufYbpVaeCo965foLgGxZTWbc91dVylt24unI1jlwvX/8Z2QKjh
         YEP8Mt+6GA7wC3dz9+f2kwUcNRrmvxmb2M2POBfrHnk66edkGzjHW4J20HdICquFr5UC
         pfYowchQVfT5BLmb/v/bXy1usbVAkjJiXP/2dugI+KA2a+KO68DSlbJpsob+G3pEDb7S
         qHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764781946; x=1765386746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dMlhUa22KWJ2ilQ42UhqcCRS5uDTPNIwpYqFYW9E1I=;
        b=XJSbb8MEt86GfYkrv5aZIK85PjlpZNr6Tc62NJmeWJr726Cm0sAE4qkdcoLRR3FoYj
         m/4ZuefnGba+W0nR1D5UR6gVBzMMQXi6V25qrPIBLv0qtpNU3KSuVvB/4KG2gxjfm2fC
         QYwzFBn9lNErMm9s8wjriRpMPBpVSLvmIGm6yN8oS7iPhhHX/iG7ajX6VW793KLjghbU
         CxFt+ukWsBh7kn4B8SYGnQl0ipvPp6BjHJuaAX7VPiHs6B/4AZ1I0eLcvU6Ivm8NfvPN
         BKQ7nQAZAZFxl/EtUskNup+Jc/hdlrGD2IuyYnJlSLYttWgGOZOJoXPAWkqlrUh4l3Iw
         eEEA==
X-Forwarded-Encrypted: i=1; AJvYcCWtsydI5XThwmweFXs0XQBz0Qaf6qLAmBDyb9e2mfNE2OS8wnOrpj/NNq4DQBSE1hMVhIvCzIKA6szpzKDO@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtX9AgCnPKx1CpKs34K6+A5I3f4rOhMUwabGV22foO0ylkAfG
	MxcI0BFzv53MHm4bhCGqaGnrxut/lsGtzsT5pTxwieX3nhYVY+8g9foc
X-Gm-Gg: ASbGncsP8ZAQ/9NcJB0RYOe9fiIku4VObnBZZ88s3U6V8zW3IfSkmnNmfs72+gZ4F/r
	yfxQq10sd8lUE0J6xbRFk7h7bmPLvOH96s0p3g3HLI8e6LlsiI/C1WCvindQT0kMI1QjH3Fkajn
	FBmJ6Ypv4aUtxSvcrvGmHBKoHpO8pgi/vRuAfEYo30+KjNCuhqbGMqNLGEpiaKAtAFA7STOtvuV
	RqFFNlzQsQCNT3UOB0cOJ52Hgl4+/q4F6On5BEex4x3or3MxRAN31rrb0RJ2xzYMqfpEYw/Q7dd
	N/zp8tnO2uuD30uWeZ0c90faBlkWjw0+uUbxxjHQt2mITmrO7TxIBa6loUmTvM76kuelaorzqzH
	TdMZtXZQLtCI+MKEPvPZR5aANenyaHwZBT5EsJ+IZPwSq9q0L8YzeLi5zHP9pZbt7KtqhDMEMpH
	gfOZc2TAw=
X-Google-Smtp-Source: AGHT+IEFfaor5TGluCdJ9VR8/Ps+0lVeXujezt2zJVQtO7vKz7xrftaiA2O5j0+xom7Jt8H9sL17Gw==
X-Received: by 2002:a05:690e:11c4:b0:63f:adfa:e5ff with SMTP id 956f58d0204a3-64437038548mr2177966d50.57.1764781944118;
        Wed, 03 Dec 2025 09:12:24 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050348sm7461970d50.1.2025.12.03.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 09:12:23 -0800 (PST)
Date: Wed, 3 Dec 2025 12:12:23 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aTBvd6I5D3VAT841@yury>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-5-yury.norov@gmail.com>
 <20251203121007.407eaf3d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203121007.407eaf3d@gandalf.local.home>

On Wed, Dec 03, 2025 at 12:10:07PM -0500, Steven Rostedt wrote:
> On Wed,  3 Dec 2025 11:23:25 -0500
> "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> 
> > diff --git a/include/linux/tracing.h b/include/linux/tracing.h
> > new file mode 100644
> > index 000000000000..1989e6328c59
> > --- /dev/null
> > +++ b/include/linux/tracing.h
> 
> Sorry, and I hope this isn't too much bike shedding, but I'm thinking we
> should call it trace_printk.h. It's mostly about using trace_printk() and
> other similar debugging aspects. Calling it "tracing.h" makes it sound like
> it is part of the generic tracing infrastructure.

I agree. I didn't change the name because it seemingly was a consensus
about it during v1 discussion. Let's wait for more comments. If no
other issues, I can send a quick v3, or you can fix it inplace,
assuming you're moving it yourself.

Thanks,
Yury
