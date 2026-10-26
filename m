Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055593;
	b=IlLD18FTfIrFu1muqNzLD+7cF9EeuqI7Mu+ezdiNaqV9sH+tln53UQqrIKwc/l9wMB2W
	 TOCwBUhND0gaHr6qk9bkbzf/8xbnH4CYv4qxj4pni4UveV+Wgl3zdFk3cvu4riHfG22Bk
	 vK3HEklD3f+fdYNRkPiXN/w6lc8dl2NVxAZHj+xgcFXa+zETCxDaUhCnOlXDNAfZf050k
	 xmC3mR42eJmT1Qjczgjm+okr1gc1fy95ibEpWlpyKO/W1SQkLnlWValNQ56jaLzYKaXof
	 kkYKweHacG7LbXuI6colFvgo3XzTAHVYn9WeSzX2GoqJzHWnaYzJPJLUBNHqOnNEKjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=xYFlSdYSBy4efBRscq6PIWjy+kL+seLzZByRLeIBFMw=;
	b=aojJ9ON+mAWIdJVoo6V3mjlrZZQWIosd94AjLZnroCMOfoVaP+wi4L1ALN3WTIKeQjrQ
	 AY6s7R1N+H1Gfu1C4AsIsdxSr4GlAnh2IvCKUhrzzuCWW1IBujW/V2EZ6u54PO87iY3ZB
	 e19GfY9VspfNRT7yzVC2QeKmxUlq7HHEZ7Ur8xklRvMnUhb54zGElkhDLtkzxfCB/4SMo
	 2ZS1RbQ+Pw/8uwS4Js6Sq+YlQ/hzLUT0EkUhykHOQLcvwH8oOAQmszC40YZlzs7EZACPK
	 JWS3hx+9p3mYM22N52gek6Z5Y4jzqWcVcrhDMQWisjRaLtIkayQ0MNm9KIhltOt8LHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JtgX6t4H;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD8606A323
	for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 22:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24BD8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JtgX6t4H
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53394bffe0fso3906001cf.1
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793055592; x=1793660392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYFlSdYSBy4efBRscq6PIWjy+kL+seLzZByRLeIBFMw=;
        b=JtgX6t4HkHHesY7n2JQPJyp+pm6/msV+LFkLCJeK62zQwbPs2o0eO3GuMpiwLyNqUP
         WdbCdxG4OXTrmFVlJcvkBmXQ9YK0s18xT86CS06J9aePaF02lGMjkyV+i9+s8AUyZYEo
         sVBYaHLO/lJaW0Nf3fxwP9S6DP4jpS3e3B7HPfWGx8noGECoZeSPzRqN8XrpE4+O7Hd6
         nE+g5KgftytnmNVxGTrNW812PMJZKe7xsMJRVS1IsYJ+7VcaMIV2Aq2Mx2fYBPvmFlNB
         KVI3wubDsUSR0XMK4VovCsCi/Ayb1GFD6RmHsKOHAd50F1EKGy7VTJQkptwcIKutBLP3
         4sVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055592; x=1793660392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xYFlSdYSBy4efBRscq6PIWjy+kL+seLzZByRLeIBFMw=;
        b=PhRuK3hmAUs8My5sWUWdsp6RQlwl6IyKZfDBqPweNq9r3Kv3F5G0qU6ESauwnsLcnZ
         pJkEKJ4LwKTBzqEM5SEJS4/6fyd2/D4ZOfkcz8BXjjeI4TqA1libOoPDV1b+ZIMDkTNk
         DRJFq4u3oN+tlN/jh3ZSzL+zVLS3IIWVLpooGFC5wDu+seTxIz8WFnFi20Y4d81TZoX8
         LYV7Fs5xANFvePUESUFNidQ1QFoPjtcstmtad8YxVcwx7vu0gMUQGhdn4a6h+lzFKXiB
         mEvWO9cZtSZV9mHEnhShice29EywoJGTwXfs3nO/l9dr3cbUhhtRm9cLlvq3Kd7tmYz2
         6r9g==
X-Forwarded-Encrypted: i=1; AKwUvBy4s4ExNdTwtePVsSgW15yFumUpiSv47cgHQCobT0bGLoXA4pbp5v+gTLmUrkrNq2XHhvyV+1j+rsf3/B//@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4XrAwJxZiGYLaHGx8e5iyI16XSQLHwFxnG3jU+yniuH3pKs35
	3lVPPorbVhJUpYhO/BZthnT6t1hKjJhfSiU950YcoJ0cAomWDKU5huEfhQUbFfCDI6s=
X-Gm-Gg: AYBFou01AZWxOv4n/Q9TAPuM1WcBNSWnJtQ0rFJ5u9dqiVpH/lifRZOj1obWX6Bcu2B
	ycwAeU1sTsKPprfj/DSUzXBTOtHmlMU7fkoc2pdkl9qhW+2ENeXUhIOL02XF4k8j4l0iiHCoMNz
	9jP6w4on/SotTosHONVnl9jrHBpy/vufolP3KXhtqfZPhX9ULi9p/voeRP9QgvfGyZp5lU5z2Mq
	pYLWKD0fZAviboG6laC45HQtwPSiUEBFtquctNc7cH3AV7jDOh41l4K/5U/hSn6EySrFf0/JPhi
	RZp1gMObFr6S9a8p8vJWCiVCFP3WCWvdFhp/W5fJ8kWMzuquyNeteJiElRGFrgv/9QG0GQql4tG
	iTWHOYElQ0eXg3wHUgPfuC12Q6070e1vVkxztj+2tbZfaA3hEb34siot5G6jUQpWtqJql5UF/ky
	Q9JCQnT+AWOSg5MsygIllXohSQT/nxaNIni8JbzmTF51S/fp8YHV5RnCn2S6JRwtUEEXdJ5QlWQ
	AiRq8v9ZyM2CwyOaAtaSZPgTAc9voUV3kruVTE1ZUG+MXRMOFSgZnuAdDvtS1ApeUSivUjQv4oZ
	tUA0kVi1x2fuPot3AqxJYI9YD5ccuOYNpsmnkA==
X-Received: by 2002:a05:622a:5c06:b0:536:60a0:5515 with SMTP id d75a77b69052e-53e3f95510fmr21198101cf.17.1793055592065;
        Mon, 26 Oct 2026 15:59:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383970ac84sm65824991cf.20.2026.10.26.15.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:59:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLTfS-000000089Kh-2dEv;
	Mon, 26 Oct 2026 19:59:50 -0300
Date: Mon, 26 Oct 2026 19:59:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>, Armin Wolf <W_Armin@gmx.de>,
	David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026225950.GD1685504@ziepe.ca>
References: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <at34UOuYv3NtX36R@monoceros>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <at34UOuYv3NtX36R@monoceros>

On Sun, Oct 25, 2026 at 01:48:04PM +0100, Uwe Kleine-König wrote:

> The more I think about this taint, the more I believe the commit should
> be reverted and replaced by a some stop gaps for driver_override. (Be it
> a taint or better yet
> https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com/
> .)

I also think this patch is way too broad and should be reverted until
something better is designed.

To me this is very similar to the filesystem issue with syzkaller
fuzzing the block device and crashing filesystems. They said
filesystems touching untrusted block devices is out of scope.

Same here, kernel drivers touching untrusted HW are out of scope, we
have never supported that.

I think a taint from force binding outside a match entry and using
new_id are probably about as far as this idea should go.

Even this would still regress most common VFIO instructions though, so
some kind of disable for VFIO would be needed. I don't agree with the
assertion 'servers are already always tainted' that doesn't match my
experience at all.

unbind should not taint, we support hotplug, and manually binding an
authentic match'd driver should not taint.

Jason
