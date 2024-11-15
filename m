Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B22126C17;
	Fri, 15 Nov 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652257; cv=none; b=LtyyWjMa7B4gi0Z+sdILNgwTBzj1QFfn9hIHmt7L0SairnDFqsvpZMitHgkT7Doa6s7K6NyfkDr2Gmd7ALuL5Z6VWykf/GThECpL0b1ew9DqMTAmbx4SVRn9SJC11xDAn7dZnFGuUfkQWXWsQvfwmeTtcopsDkb8KMK4fBV5xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652257; c=relaxed/simple;
	bh=jE+fcubQiJTZYuRKvwt2hu15vk3aNy0fI5FIkyuJ1V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrhdLvKb4NLNQuRSCokAvV/qNUS9gaONQmfV8uY6wCHJwhp8XWhtzEi9AvDprr5ChHhyo/bPYnXq8VIe+n0akDvnJqt93UL2mnYURo2Hk6TazKud6bGEsjcH61nIJTMM6G5zw+lFOtT/gQkD/kwyvEaV36aDBz8BlCybDrNinG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vrBRiE3m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vrBRiE3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7422C4CED2;
	Fri, 15 Nov 2024 06:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731652256;
	bh=jE+fcubQiJTZYuRKvwt2hu15vk3aNy0fI5FIkyuJ1V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vrBRiE3mUalIe8T51KZHKXNwub6M4lwjy4kYvgmbdj14qR7dVu9EC1MnHEt9X3A4T
	 rf6ZueEJZXGqwnIQWFNvTZiXmlKOkVjgQQmWs9Qk36B4eFl+LvMjtiHoAeRUZhPIn2
	 mZcOw7O0Zz3GCrEcNfPiywFcEA3z0A2r+hzugQyY=
Date: Fri, 15 Nov 2024 07:30:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <2024111517-booting-grafted-8c4c@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>

On Fri, Nov 15, 2024 at 07:09:49AM +0100, Werner Sembach wrote:
> Hi,
> 
> Am 15.11.24 um 05:43 schrieb Greg KH:
> > On Thu, Nov 14, 2024 at 11:49:04AM +0100, Werner Sembach wrote:
> > > Hello,
> > > 
> > > Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
> > > > Hello,
> > > > 
> > > > the kernel modules provided by Tuxedo on
> > > > https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
> > > > are licensed under GPLv3 or later. This is incompatible with the
> > > > kernel's license and so makes it impossible for distributions and other
> > > > third parties to support these at least in pre-compiled form and so
> > > > limits user experience and the possibilities to work on mainlining these
> > > > drivers.
> > > > 
> > > > This incompatibility is created on purpose to control the upstream
> > > > process. Seehttps://fosstodon.org/@kernellogger/113423314337991594 for
> > > > a nice summary of the situation and some further links about the issue.
> > > > 
> > > > Note that the pull request that fixed the MODULE_LICENSE invocations to
> > > > stop claiming GPL(v2) compatibility was accepted and then immediately
> > > > reverted "for the time being until the legal stuff is sorted out"
> > > > (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
> > > As already being implied by that commit message, this is sadly not an issue
> > > that can be sorted out over night.
> > > 
> > > We ended up in this situation as MODULE_LICENSE("GPL") on its own does not
> > > hint at GPL v2, if one is not aware of the license definition table in the
> > > documentation.
> > That's why it is documented, to explain this very thing.  Please don't
> > suggest that documenting this is somehow not providing a hint.  That's
> > just not going to fly with any lawyer who reads any of this, sorry.
> 
> You are right, that's why when I became aware of the situation this Monday https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/9db67459510f18084694c597ff1ea57ef1842f4e
> I got the gears to resolve this into moving (me playing devils advocate here
> is directly related to this https://lore.kernel.org/all/17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com/)
> and then returned on working on the code rewrite for upstream ( https://lore.kernel.org/all/8847423c-22ec-4775-9119-de3e0ddb5204@tuxedocomputers.com/
> is directly related to that), because I'm a developer not a lawyer.

I would strongly suggest you work with your lawyers now as they are the
ones that need to resolve this properly.

thanks,

greg k-h
