Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F821096F;
	Sun,  7 Sep 2025 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208119; cv=none; b=meE179G2t3HY05WlEl8JfXhybcv4rLWevccAcfAzV4/SFPc9PhMlr/gTeH0lgybjqavmeu/fxBQW/x9O6koliAtzLGOnXkcB0XZPJw8G2YgUdeK0fTMsI3vgOuLvypkpkS+S1CT12hoI9FBGtDuMxf0q/8zn2/zvPqpLFdPFBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208119; c=relaxed/simple;
	bh=IfOoH6ZJk5z5/Em5S5RCpfSsydkb9mwp9ZwxE4t1edk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1D81dvoDR4l6TdMM5H7SoxsgYSSnZ5FKG1lDrasxoQO6sNfpUpu0/GK9uS7r7g/xeIy2tj/y+bVgoqiol45Da8yCBMhhECWFhR4fV6Tz4OiDu1KtBcKl4Gy3pwPC0NsuA3AC4yNKSdqWVjTtPrC54AJRWqNo4+SBfbDlM/moRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE7iqOHs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE7iqOHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE33DC4CEE7;
	Sun,  7 Sep 2025 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208119;
	bh=IfOoH6ZJk5z5/Em5S5RCpfSsydkb9mwp9ZwxE4t1edk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uE7iqOHsTLnbc8TCIYsfBXtySBGh9LnSNyWS/XUnkjoA+2q0oNwc5KXVrsuzQw3j6
	 yegu7xz2hVa9eN4xbGwM8DB6t2j8o8+EsjgJ0wJa7jsfQihoFoCkcE3FRjpkLpG5Tn
	 HrXCb7otHRxEcIL6a8GqaoghbSQpwF4joqaQeOTdr/XWqTGcX9rTQIJqOTIV8GpyTV
	 tx2IMD0Q4Xcn2yp1ci7FxmbboufpnE8nb4lL9dWY+FkT00ytL0flat2EQHBFHnGNRq
	 z4vLJdpdWzeyLbpSPcVS8ZLde98otl5wjlVW1LMpJmIMjYQjpCarVSMiUO0b8H7tgh
	 NRqc5K1FqGGig==
Date: Sat, 6 Sep 2025 18:21:57 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Fidal Palamparambil <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/acpi : Fix multiple issues in ACPI boot support
 code
Message-ID: <aLzeNeOaURLg88GR@bombadil.infradead.org>
References: <20250906121711.1647-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906121711.1647-1-rootuserhere@gmail.com>

On Sat, Sep 06, 2025 at 04:17:11PM +0400, Fidal Palamparambil wrote:
> From: Fidal palamparambil <rootuserhere@gmail.com>
> 
> - Fixed memory leak in acpi_fadt_sanity_check() by ensuring acpi_put_table()
>   is called in all error paths
> - Corrected error handling in parse_acpi() by removing incorrect snprintf() usage
> - Added missing compiler_attributes.h include for fallthrough support
> - Verified proper NULL pointer checks in acpi_os_ioremap()
> 
> These fixes address potential memory leaks, compilation warnings, and
> improper error handling in the ARM64 ACPI boot support code.
> 
> Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>

Please stop with your garbage patches. They are not welcomed and wreckless.

  Luis
