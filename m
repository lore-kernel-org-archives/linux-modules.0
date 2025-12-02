Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA412F90E9
	for <linux-modules@vger.kernel.org>; Tue,  2 Dec 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710312; cv=none; b=I8oP9AszKp7hNxUHqeMlZmMt+5we/HntjgAh75jXU2SQebYaxxk1tPdeax+jCo+FYDLOscBimlGi5msFU51pIeyTJUtcp5qHPxty427l5ueV7zPZJiehDkB7snNuV/KgI83v6vRX6vvTHOBYpIcsFe8FrALkKKLCsmG/CS52Qmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710312; c=relaxed/simple;
	bh=TxpGRGw/pVRDHTZum8aN1QNo6n/+VR1tW4e6RQDKvGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhELvF7wkajGjp7VGfiAWZIw89bCV9X0Stqf+q9DP0R4sp9K3ZlOAJj0Zs0ADkW1Gg1RIRL8zSwhdwwKLA0FIe9zx2W5Kw6XYAoaPgjfrRHBiBxd68BJm3pIyj1CFNbkTVYW8IJsGLbQHC+FpX6Ib225ZGIxohibL8VkPMKvvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaxTiE6R; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaxTiE6R"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64308342458so5441951d50.0
        for <linux-modules@vger.kernel.org>; Tue, 02 Dec 2025 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764710310; x=1765315110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYhGqDRGCK+cJn0UnOIQPro7GrvnzPHTnrrQsLBmDCo=;
        b=GaxTiE6R6LfqBTW+a8wBQm98OMcMnEZWZBOJDunJdO7eJ0OwezQO2qKKJvw8HceFU6
         Cub7mz74pyHrH5ywafZLUd1n7ls0Z8vk56Vk2uqoGue1UJ6XbAseR4HKMgZaEIrQH8Qt
         6Eapjil7ZWU1f4soLbJp/bTFpXGEJ9x5Qyg8B2xz27MnXETwuVO/KzX41BtKP5DvTXiK
         F+uGavL0vmH+cAJH8i7d0CwVE8QzCiNwD4INNpIzjzsTwBVq3hXOrIqVqnvEIuHnrVpr
         rHGY6/64UnoQsl6AvBeA8y8c/MVZIVfJxwUAJXJdU60hxjT21ZGcBAqxAqm4mr3I6Xkw
         3udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710310; x=1765315110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYhGqDRGCK+cJn0UnOIQPro7GrvnzPHTnrrQsLBmDCo=;
        b=xVYIBw+Mpb/zRTLrF71AKx/9k24KUxJg5Cy6d4QVDnfH0hRJc0nWjdJGogteJenfuj
         tz8zTeJVyrHL6HBtjGLjLfIU1+a5ixQUgUTeaae7pIh6A2H+9FtiLKmzurRYsjQ23oTV
         uho/JVzqLDZrd5vbCzXk/kRRWk1H/dkyxKCZQp5rGQ642bdNcQQ1hyZb2lhwr+ZvjGIp
         Q+QqVWLlcKMbmuUk7puVJIGjDFRrL4L2NLujyHQgw1IhBRlW9JSeBh+ul/x7e033G0an
         67KevZ8Fja3+n/tgP4tlAP5+Vvcd54KrDtKfKoElhwHhuZRO9pteRvBUL85odKk5ZOX8
         /0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsE+LdfQKEUkO77JiVROXVY3BhhSFhn4HlmHqkqjq1/dADGe95H1SFCln90p3I+pYs7gyh98on5TpnbfYo@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCTtJhvOE5coIl0KLUy5DpHwwCU0qYRmriMmODN+4F30PngOw
	toTynl3lceel3KCJPAJfdcGe2vxk3p6xos6HckzCTkKCqtmZFnGwdW6t
X-Gm-Gg: ASbGnctpCPFh7vCMshITpKMZdXmGucX2J5m3TkWECXjWOBpOV6d/L51C7MeGS49Gy10
	zMBcUP6gRZaB8RgmpmmSXEam5PRfzmy8wTySXQdAVXw9HewVFWG8Rpj0pDOIkAkB7Z8L9eqHalD
	hbGIDWUO/ZSaIOTEzav+X2CsZtHg1pGWuwQ+UDMcu27uyMila7LWE+EvWEH+QNvP5JA//Q4zFJh
	5+Zw5QG7fY6w73WTaK5FvXwkPzTCm4jTMp5apDpaeZdSzdf+Csb1ArMZumZ0s8W1r8jxqk/LRGw
	oRXnwt6z2XexraN516U5Gc8outfGWlN9IjZf4q1alSj9n7a+6vAR8g6eSXjw0rYeOXoEslqjOje
	8Gk2XlXMVSRJ39Y49ScKRbssmNqEh4T892gSN05+/qvoS/c49eI25YKNO0hvzjb/vW4hjY4Pv3I
	MDGuR2IlI=
X-Google-Smtp-Source: AGHT+IEHsQzpfTBjBHA4dtIeH7oiiPcnL1uTXbBAuV28ldULX2+K4VUyMpGMegei8EdtYuGbElbA8Q==
X-Received: by 2002:a05:690c:6f13:b0:786:7aaa:a070 with SMTP id 00721157ae682-78c0beeaf33mr40397b3.10.1764710310027;
        Tue, 02 Dec 2025 13:18:30 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad100e937sm67330467b3.27.2025.12.02.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:18:29 -0800 (PST)
Date: Tue, 2 Dec 2025 16:18:29 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Message-ID: <aS9XpaiGXn2upVKB@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <d854dadd78a43f589399e967def37a0eda3655c2@intel.com>
 <3m64k5fagw7hp2duo43t5fldyn6argdjripx3nn6onxbr6xu6w@iwiepyn5krf6>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3m64k5fagw7hp2duo43t5fldyn6argdjripx3nn6onxbr6xu6w@iwiepyn5krf6>

On Tue, Dec 02, 2025 at 09:58:19PM +0100, Andi Shyti wrote:
> Hi Jani,
> 
> On Mon, Dec 01, 2025 at 09:46:47AM +0200, Jani Nikula wrote:
> > On Sat, 29 Nov 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> > > The macro is only used by i915. Move it to a local header and drop from
> > > the kernel.h.
> > >
> > > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_utils.h | 2 ++
> > >  include/linux/kernel.h            | 2 --
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> > > index a0c892e4c40d..6c197e968305 100644
> > > --- a/drivers/gpu/drm/i915/i915_utils.h
> > > +++ b/drivers/gpu/drm/i915/i915_utils.h
> > 
> > i915_utils.h is on a diet itself. STACK_MAGIC is only used in selftests,
> > please put this in i915_selftest.h.
> > 
> > I guess also need to include that from gt/selftest_ring_submission.c,
> > the only one that uses STACK_MAGIC but doesn't include i915_selftest.h.
> 
> Doing this cleanups is a bit out of the scope of this patch.
> Given that the patch itself has quite a good consensus, let move
> it forward and I can take care of the i915 cleanup once it gets
> merged.

I'm already testing it in my tree:

https://github.com/norov/linux/tree/sm1

If everything is fine, I'll submit v2 with this change, otherwise will
schedule it for future improvements.
