Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040200;
	b=qLjoaQL0JT0iEWWsKwUBoANY8khyx11csaqgoRIY6u+qPDhSc4eYQg49LpQk8dVnIOek
	 hM0E8Of32LJNyO2GdalUV0N50UprifcFa83FaQ5iEau9kFZKIfryKHaPHhALlA95lp1o0
	 Dle/ajXjIqwLt7X0LzXFe4RU2onyWKIVRyEy9rAWqbaYQGx8pl2UNIzz5HcM9O8yGQfjG
	 7N6q4QHtNpIkHtn8LvoI3l40i8/HJPTC90k4gJpck9iWVjLO9WKwm2a/fSoX+ZMjp96p7
	 LrI7dPGBY9IbN5OjDggzEn3jq6BdPYIZZQtc1q7NG+iEPohEmvfMPaKKgbqW/BLwEnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
	b=U+dz/KwcNcIheJvCFCsSMLTW1x8Vf3ZzxPkLDasZDrDT3HBSExi4M2v5gsCvXblmwkda
	 p4k0vstoCFn6s1RwkoWAQ5Gey0nUUPcS7Xeh66XQNwhlniDazW2DNvegdkbOhS+9ju8cf
	 zzREfxkFI+qmzaEvAxnskcKbeQNCJ1TYc9TyXcRCltqMQxF6b436Wfa/1RZN+scy/GRvA
	 ZuqAYJ+QbeVUgT8BGQuzq1foz4uELri8mc4rg0WHTvoNarSf/so81+xl0BIKCGflZ7ow5
	 840+xtyI90WVrnxmKgx//dHdThfbodyvvdjPWYswJvTcSbmsqEwsYEI5oC07sOmZguQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF0606A31E
	for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 18:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38AF0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f22a8515eso306277885a.2
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793040194; x=1793644994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
        b=azZPsctqXRKqpOwzOSUanbXvvxd+v2oxaACaz4naHK4U/NBQWTZSH1+8VRwPrLVwY0
         DocnyrGmPyv8LQRxTMk4K4sAlQVJBR98rqP+2aWoEAiU0n2xJtP2lXe11PdsBX9zw7zH
         rykKuo4jE8Sw3g1ZHf1cUaz2vGbXwYAs98RHcsf375OaxpJvYYqyPF71AEMIeOtk1CIf
         vDE/ajmi0uLVqaMusVBTVkVR8NUGi0AybkTdqBwAenvqpPLeBFRcUdif9SgXW44+UVBP
         XcslWkg4kCuQnmXySZ0RwdZ8wSe243a/pyuPpY5dxc6Pr/hlCqlSwaLgYcUdwFY6ZPLq
         p4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040194; x=1793644994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZWci1OY37Q98PjNDa+DsqfD5q79/im0Ez6T5Vupv1s4=;
        b=MzVnZLLlDRP7fyX7uwc85Xscz+HgLXAYA6K+49q8M5KcWcS1/14DVVOJfORZfWXOkR
         J02SvmggYkLWGjSCZ1q9kMYshlB+leZNsD/kWf0i3Lo/yCEs1XPhlCfnkHcyWDWr7cev
         p4efcUskoJKGCJfD0vmpu9DIDpasAjs0wVGn3mil7sOR43l+nw9HEqeRm5ggOhdYfnrm
         Bkt62MjNQoIeNnv0sim9URtUSoHSRwZlUPTzGhz6S1pNxVwMtwT0UEhaQp2x3s9oJDeb
         Vl8r5DcF9+e35a22LeSHaWgeHXBt7VfEn0HtxaWpvJNfrTcq6QZIOVZtHrO/PuUoGyGB
         H1Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxDInPirIo/ijQcqfqcKCFsuQe1bHRLpOqWJMWrQ0OsxYAZd4woz/FKVIDoHKcBug4KUjMBfEE/YrBS7Eyl@vger.kernel.org
X-Gm-Message-State: AFq9FYJqrEUu5oBjEo8DvOi+zN+IRp323bq2tShcvESeAAXUaIdAwSci
	8e+aTaOolKetoZnsEkvX29lIRrlaIMJ69HG5pKn+ESvMvrg7XpOy/S0mwf41VVcidfo=
X-Gm-Gg: AYBFou2fZuXEdtoFVeEOJvKbSCrlcik4T9hqy6grbEZYujOWA41YOUVB3s0xXWpfvCC
	wW8HApyBWVkVNnhuwRb8HqiQTnwvKJT6jhHkr03MPnyuSxs0L0foArYuMP1kfSahZs5JTjSnf8Z
	iR3zLuQ7Q77aVsx+nyWtc/RoJENnfRZV8+I45CnY5FPq3IUDYXkgstDHOTmWKp7TluMMs79E4hG
	Uxm8y9yC01F/nkpcNrJqEWUn3cdsSSIMNlzMQh7PhFgKC0EkNyV91khKGHAnlUABDFQKiAWRbg1
	tWkuutDrcjMq1uPzpbiYnkWtAotxPD0YEstCCckFV/45O8cZLNs0Hqa7MVLjhk5DEwAnRz+1WyG
	NeLn/V/FnU9sTbJSBd1DrJqAlMD25HBJUc2tN7fKC89/1wtmfIylJXw5sbGpY0QF4nESlvkeMyd
	nKJhsoV0weD1B3a3DfVlB54yVDLs3D/rEeAPJ9EUpG74z72oFc5EUU3eLX+vpsq4j41LMpPchQ/
	9WlENDIj+3UnJMvcZ9exM97DZDsybZtxHtWP3FHZ03KJCTudyRJSC3ack+J/7/pYHUZALD3nvq/
	jDetMYR7G3N5YceOvCjKy6l37ZtubuGQyq7FxU/NC8lc0BBc9VGxLVkUBBDsEB44RJp8venv99N
	emsQ18cSXTLE=
X-Received: by 2002:a05:620a:172a:b0:939:6c31:2318 with SMTP id af79cd13be357-940ef8d8389mr1233127985a.34.1793040193950;
        Mon, 26 Oct 2026 11:43:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067c879sm758709385a.16.2026.10.26.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:43:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLPf6-00000007foP-2hO4;
	Mon, 26 Oct 2026 15:43:12 -0300
Date: Mon, 26 Oct 2026 15:43:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
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
	Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026184312.GA1685504@ziepe.ca>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026122243.GA28851@unreal>

On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:

> This is needed for two reasons: to save hardware and software resources
> when creating a large number of VFs, and to allow the PCI config space to
> be configured *before* the driver starts using it.
> 
> There is no in-kernel alternative.

Having userspace involved in driver binding has also always been the
plan for confidential computing needs. We cannot have a device driver
bound across some of the HW transitions like TDISP shared/private, so
there has always been an expectation of bind/unbind.

For this case the existing sysf drivers_probe is good enough for bind,
but we must have taint-free unbind for PCI devices too.

I think this patch should be reverted ASAP, it is a pretty major
regression for a lot of users.

Jason
