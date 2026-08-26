Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0141D22E
	for <linux-modules@vger.kernel.org>; Wed, 26 Aug 2026 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751203; cv=none; b=dzBQ65TK0f9eggcoAe+X6FiVNixaNC/2A/9ltiH8VcgyJXYiSnIhMbxkTrQmoBKZC35RB0IsA+7CaZd92s8zwD7/OG2BLmAntN7RRTiqLJltpIwtsHMKXjIE9EGnK3by8tiudCNsyVF3WEyktP0IWPOzXajPcQK3vmqDVXrFLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751203; c=relaxed/simple;
	bh=skh1J20miHyQI+YX6SjrUI0pPMNxBurFeVoXPbNyAqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMdFz/pXcX/hcrgg6XlFHm7KxlIqMqAwx7jsjeP61caW30eTMdxFY5c64tE4H8kW4nqMZYIruJCcLJlFJG7Um7OQw/ALlhVZQ0eMqvSDEFdqOgkdoOk+F/wR0rlWk0q28Xl6HuuvL2jWMAXsndJi1EZ4UlcXElvHX7S9MES1y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3jprUtV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3jprUtV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e1bfcc63so661635f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 26 Aug 2026 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787751200; x=1788356000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eDeYb04JA1wKUlB+4fT7hBu1dYeSHzQSzUnUA5UoiTk=;
        b=c3jprUtVQbhETdxCm6+ylXMzRdkNb5d8VOq2/82y9Gnsg3XZY9bBpfHfOBKK3nLgLV
         3jxszFUSj7uWNo9rdwFjyJr7pX2PII0A9DohLTxTf8b3KT0BCuWUnMqb5Yjn/2zcJEPN
         en/lU0QsLn7hSUze0FUqtrG7JwN68xGMbZNSQO/YupFlSTN+RWuj5dzrvqSW5DgBp0UA
         VZSZRHegLfpTO5rPb3EgXN4Fj9ISh+PjEosJp/rcWM1PbuKki1kOhdh+JXu9ub8TTmFS
         GXghIHP0hcos1PTLWyIGw63Kjxp0n8n3PWjkTnMADzJmmjILNp4eBa6Fex07ZpF0Cz3o
         Yl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787751200; x=1788356000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDeYb04JA1wKUlB+4fT7hBu1dYeSHzQSzUnUA5UoiTk=;
        b=bW9xIEuya+RHUzci8KuO4AMrfk06BM6KjtE0TU+H0I5xwYH3Uv4GIe9di7dZBNhiKH
         /wAEPPsJkDL+OVUM8VY5+xgRuC/KMfculCNn/XZhuAzrhogxXlOVQrVK9n6r8OpDx8Hc
         WRrY6aTOHhjVzELfxljGAD4yDx2vFxGXOFjejaZyVS/1/vtWw1WKhv1ejTG4g0gWH/ro
         reYIgz7czPuMrzjP0s1w9F49RPy8jTeE7cl4lUfUNd6Oe7y82uy89zUkKrv1s/5DT4Ul
         Iz1K8/HnxlvxHl5AFh/BtlgjHbiShK4r4CU6A9L66AV/SkN5Y2lhSLx/31E9Y0ON/qFZ
         3LVg==
X-Forwarded-Encrypted: i=1; AHgh+Rqpp9ldgYymF+KKiI23dp/EDiIldL0ghQxmcM+X6Qxhr6Styr/lWZ0+V/BmU5PtgSw5S5KuEPdrNsaLdPYK@vger.kernel.org
X-Gm-Message-State: AFuF++l9BChjolpDpifVw6DUObv+slV2EGNqbVlLz2yUor0uAaEa6TPa
	qPT5llLBGoYQyAmtfVDhDTSilqRbiklPr53S2DzvzVK6+guDfOvh5AUt
X-Gm-Gg: AR+sD108J2Fld2ipzuaW9LvGeuen7k6VREJtJYcDN7VGTtjfdn5opSCwluetZK1Mzmr
	0lpz0F+EAw9jEqYhhJsrJVZKg40azxGLfiCiYSghKEIzzit67NtT1stvO59i9E5Y0c3YMe0o2YA
	SxfQNCgwLsQwlJHsFayd9+23rqmtb9wVBsQgGRlOjIEUFPP2NM/hPXD2fRTm0sSqPmEfyFsJNyd
	CfxRkIIClktaLFlf5+JM1KXoEWcC7cMfZUbyI53IObPgyWIAYF6l69VLD7wFI3kLTwWvpTzbzjS
	GmnBsrP/Ryw6zcHaQBW7ZgLShvLt5JQTqSOUgnNNJ/BbBmFUlpKxm/R+Irrdv/NJd8sRZIbdTsN
	zXd/gVkmAPt0JgUrUX33hwYmEnAo/gLbvv3oljteOFUwNCoNpc410gGzO+Sv3wPu8UWFc4/+axK
	dPnnol8M75dK4iYRAiAedjyVFlyNV4qvHvBtr575WUFfnoMTWBk+awSW4os417LDLM3Xs=
X-Received: by 2002:a05:6000:29d2:b0:482:dfaa:dfa9 with SMTP id ffacd0b85a97d-482e26b3278mr4456632f8f.7.1787751199354;
        Wed, 26 Aug 2026 06:33:19 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28f6119sm2777848f8f.34.2026.08.26.06.33.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Aug 2026 06:33:18 -0700 (PDT)
Date: Wed, 26 Aug 2026 15:33:11 +0200
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
Message-ID: <20260826153311.6340efcd.michal.pecio@gmail.com>
In-Reply-To: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 11:19:31 +0200, Greg Kroah-Hartman wrote:
> The ability to add and remove devices from a driver through the sysfs
> "bind" and "unbind" files was created all those decades ago as a way
> that kernel developers can iterate faster, and provide a debugging way
> for users to attempt to add a new device to a driver without having to
> rebuild their kernel.
> 
> This api over the years has been abused and recently come under a major
> fuzzing "attack" through tools like syzbot which decided that it would
> attempt to just randomly bind any driver to any type of device, causing
> loads of unneeded errors and pointless kernel patches to be generated by
> unsuspecting new developers.

Hi Greg,

I think you confused 'bind' / 'unbind' with the likes of 'new_id' and
'driver_override'. Try binding xhci_hcd to NVMe, you won't get far.

FYI, besides being footguns, the latter are apparently used to assign
any random PCI device to some VM drivers for passthrough or whatnot.

The former hardly are footguns and have further common uses, such as
removing kernel drivers to make VM / USBFS work or "turn it off and on
again" when a driver doesn't implement recovery. I've seen a published
script which does this automatically when xhci goes belly up...


I am also not convinced that fuzzing 'unbind' alone is a bad thing.
How is that different from 'rmmod' or pulling out a USB-C plug, which
may have a bunch of USB *and* PCI devices behind it, mid-operation?

Regards,
Michal
