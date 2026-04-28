Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF31A9F91;
	Tue, 28 Apr 2026 00:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336640; cv=none; b=m76lEiQFsThcSn1/M5ZEwVRrruL7aajdRHsBGCY6lwgf8TCBWFT8/WmCB8CxANpufBPxMSgvpiYxihkhchxeU0oj7znhe+SoGIx5cOHTvPpUhVazdqTx5DT5CxKwtX29hfDNiG68P6Z+AsK/UwA1C0z6PjAq0CZW93BHXcoYl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336640; c=relaxed/simple;
	bh=BHJBLt+nE4AsueTS+IRnK41MDsfpFl09fk2rkAOBGfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrqQ2R37y5bUZ+gC13QL7GE69tuj8UFPI63vsa4tE/xHqH92LyNpDkGs4XxaQkma45t7xC8hyym5DRQo69nteR8jxaGU5LwhVi078IdATtFM5mcpONuZ7gS8Hv6uUIX1Zj2cblshwFEAq1hOP6JxTl1IlBDRfmwn4pXQj5gr7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=zifXUqRL; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="zifXUqRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1777336638; x=1808872638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLmIYYgccj61Z7Y1BhmUJwFYcoGweKAe0uPk0qWtjNw=;
  b=zifXUqRLqy7QOyuZ6GR7zIvFQ5PKFyBlhJraaElQbM/KdP3c5G+fL2Em
   y0cMvxdb2orq0FQUtp2uKMuS7qYmrrf6pjGqXtSR8Otw/A187uyh3ikVL
   dT3nLKVYotaRW4cGjptD8018ePj84eE7/fvTNQxq/g6qj575sK6f2WVUB
   +wx7KM5y0HUdXakYQPHIreLyLBaBjaFp4rotsJimrRS3Q7VOzCAkpkF5z
   iCPwG5LFqUQBJBj8qrAnQksxPbkVf2qj1BLvAkwYnThPYeDRvBQ5q951i
   q5rsBbM1L6q5q9RCsvpok2qABpESSzs+JXAln3MrhOcfdHgEV4d0Zo8/X
   w==;
X-CSE-ConnectionGUID: p13ivIRdQeubEtPiJM12Fw==
X-CSE-MsgGUID: sWE97Oy6SSmtDOR9IaHhLQ==
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:37:16 +0900
X-CSE-ConnectionGUID: /GTJxWLWQ4+ZYLnZbAxakg==
X-CSE-MsgGUID: b3MnIMCXS6Ww/7MJqXJZlA==
X-IronPort-AV: E=Sophos;i="6.23,203,1770562800"; 
   d="scan'208";a="52460544"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:37:16 +0900
Date: Tue, 28 Apr 2026 09:37:12 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Gary Guo <gary@garyguo.net>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@arm.com>, Rahul Bukte <rahul.bukte@sony.com>,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
	Daniel Palmer <daniel.palmer@sony.com>,
	Tim Bird <tim.bird@sony.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH v4 1/4] kernel: param: initialize module_kset before
 do_initcalls()
Message-ID: <afABOMT_s9DvF6NY@JPC00244420>
References: <20260427-acpi_mod_name-v4-0-22b42240c9bf@sony.com>
 <20260427-acpi_mod_name-v4-1-22b42240c9bf@sony.com>
 <DI3Z28IZZOT9.349TTWNN9VDMB@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI3Z28IZZOT9.349TTWNN9VDMB@garyguo.net>

Hi Gary,

On Mon, Apr 27, 2026 at 02:29:55PM +0100, Gary Guo wrote:
> On Mon Apr 27, 2026 at 3:41 AM BST, Shashank Balaji wrote:
> > module_kset is initialized in param_sysfs_init(), a subsys_initcall. A number
> > of platform drivers register themselves prior to subsys_initcalls
> > (tegra194_cbb_driver registers in a pure_initcall, for example). With an
> > upcoming patch ("driver core: platform: set mod_name in driver registration")
> > that sets their mod_name in struct device_driver, lookup_or_create_module_kobject()
> > will be called for those drivers, which calls kset_find_obj(module_kset, mod_name).
> > This causes a null deref because module_kset isn't alive yet.
> >
> > Fix this by initializing module_kset in do_basic_setup() before do_initcalls().
> > Modernize the pr_warn while we're at it.
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Gary Guo <gary@garyguo.net>
> 
> I didn't suggest this change :)
> 
> I suggested `pure_initcall`, which is just a one line change.

Oops, sorry about the misattribution.

> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..ac088d4b09a9 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -957,7 +957,7 @@ static int __init param_sysfs_init(void)
>  
>  	return 0;
>  }
> -subsys_initcall(param_sysfs_init);
> +pure_initcall(param_sysfs_init);
>  
>  /*
>   * param_sysfs_builtin_init - add sysfs version and parameter
> 
> pure_initcall is level 0 so it happens before all other init calls. Does it not
> work?

tegra194_cbb_driver registers itself in a pure_initcall too. We wouldn't
want the ordering of its registration and module_kset init to be link order
dependent.

Thanks,
Shashank
