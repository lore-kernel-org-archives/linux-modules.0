Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606E14F9D9;
	Fri, 15 Nov 2024 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645613; cv=none; b=njnN4SOzKXGzjZDD6va+JhkjyP/cfOLicgFLIH2/ioQPeJMcf9fwTPV8Zv9DCe1Q5vNnxl7x2PxVx0M90vf6cD0WVuIng380HEmUdbnJ36uWCoG0+X9Rv/coc/ZJaEgZsARN4Gbj5axSDLjZxPyQ/ezfL5zZ6vs6I/LYEoqWIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645613; c=relaxed/simple;
	bh=NNxIo4hgDnBs1H4gcbNt6NjTjr5Y0EqDVuJNeGRb1vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp3ngiYfvZmy1R5ZmXdyK3+17BKfD5PRYaIbdxznz16nEYi6jRUbQILSFMOUnim6nlhYqnMVewk1LVM/4wVQB/75SxYv+qzWL1vAJt311Wkitk6cwwfPd1sA7lWDY4HRocnSxHWEvd8VODxr07FkZoXD3+sS1uqSByGAnCVsojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z8psNVbq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z8psNVbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90C0C4CECF;
	Fri, 15 Nov 2024 04:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731645612;
	bh=NNxIo4hgDnBs1H4gcbNt6NjTjr5Y0EqDVuJNeGRb1vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z8psNVbqABzbAVXFeA291j3Lcm59wwDc34ejc/1Br85LhX6jRSAh+nM2kML4OZJes
	 PebJRStfyHhneho0ojGLuo8URl7hP1it1GuUWbvFCe83eQvy6ChWl/y5uOdpCMt7Nl
	 lDu0Ezf+pPJUvK2RfcdDorHuHXscZnlumwSnJeSk=
Date: Fri, 15 Nov 2024 05:40:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <2024111507-parting-step-e5d3@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <CGME20241114103157eucas1p13c3e82272fabc2cdf5cba8ec70d2a871@eucas1p1.samsung.com>
 <20241114103133.547032-6-ukleinek@kernel.org>
 <D5LVSE2UF1MA.1TZUC95PN6Y1Q@samsung.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5LVSE2UF1MA.1TZUC95PN6Y1Q@samsung.com>

On Thu, Nov 14, 2024 at 12:56:20PM +0100, Daniel Gomez wrote:
> On Thu Nov 14, 2024 at 11:31 AM CET, Uwe Kleine-König wrote:
> > Tuxedo licenses the modules used on their hardware under GPLv3+, to
> > "keep control of the upstream pacing" – and want to re-license the code
> > while upstreaming.
> >
> > They were asked to then at least not use MODULE_LICENSE("GPL") which
> > declares compatibility to the kernel's GPLv2. They accepted the pull
> > request and shortly after reverted the change and so continue to lie
> > about the license.
> >
> > So teach the module loader that these modules are proprietary despite
> > their declaration to be GPLv2 compatible "until the legal stuff is
> > sorted out".
> >
> > Link: https://protect2.fireeye.com/v1/url?k=02b4686b-633f7d5d-02b5e324-74fe485cbff1-8cd9af635fd1f7c7&q=1&e=5f0a08bc-f529-4e41-a7a1-5aa45c54b8d9&u=https%3A%2F%2Fgitlab.com%2Ftuxedocomputers%2Fdevelopment%2Fpackages%2Ftuxedo-drivers%2F-%2Fcommit%2Fa8c09b6c2ce6393fe39d8652d133af9f06cfb427
> > Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> > ---
> >  kernel/module/main.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 878191c65efc..46badbb09d5e 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2338,6 +2338,39 @@ static const char *module_license_offenders[] = {
> >  
> >  	/* lve claims to be GPL but upstream won't provide source */
> >  	"lve",
> > +
> > +	/*
> > +	 * Tuxedo distributes their kernel modules under GPLv3, but intentially
> Typo here.
> > +	 * lies in their MODULE_LICENSE() calls.
> > +	 * See https://protect2.fireeye.com/v1/url?k=60e8a9e4-0163bcd2-60e922ab-74fe485cbff1-eff87fdcdb83953a&q=1&e=5f0a08bc-f529-4e41-a7a1-5aa45c54b8d9&u=https%3A%2F%2Fgitlab.com%2Ftuxedocomputers%2Fdevelopment%2Fpackages%2Ftuxedo-drivers%2F-%2Fcommit%2Fa8c09b6c2ce6393fe39d8652d133af9f06cfb427
> > +	 */
> > +	"gxtp7380",
> > +	"ite_8291",
> > +	"ite_8291_lb",
> > +	"ite_8297",
> > +	"ite_829x",
> > +	"stk8321",
> > +	"tuxedo_compatibility_check",
> > +	"tuxedo_io",
> > +	"tuxedo_nb02_nvidia_power_ctrl",
> > +	"tuxedo_nb04_keyboard",
> > +	"tuxedo_nb04_wmi_ab",
> > +	"tuxedo_nb04_wmi_bs",
> > +	"tuxedo_nb04_sensors",
> > +	"tuxedo_nb04_power_profiles",
> > +	"tuxedo_nb04_kbd_backlight",
> > +	"tuxedo_nb05_keyboard",
> > +	"tuxedo_nb05_kbd_backlight",
> > +	"tuxedo_nb05_power_profiles",
> > +	"tuxedo_nb05_ec",
> > +	"tuxedo_nb05_sensors",
> > +	"tuxedo_nb05_fan_control",
> > +	"tuxi_acpi",
> > +	"tuxedo_tuxi_fan_control",
> > +	"clevo_wmi",
> > +	"tuxedo_keyboard",
> > +	"clevo_acpi",
> > +	"uniwill_wmi",
> >  };
> 
> This does not prevent module rename on their side and still bypass the
> module license taint check right?

Intent matters.  If people rename their modules just to try to work
around a check like this, and do not actually properly change the
license of the code, it's obvious what they are doing is against the
wishes of the project.

thanks,

greg k-h
