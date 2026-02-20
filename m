Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8082C11CD;
	Fri, 20 Feb 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602939; cv=none; b=neGN3SPQLVIao5hB5K2iSaJVLSvZ/TjyoRdcRgGijwrOfxa3VzOLtf8ioNT9/Wes9qY4B0D6pjvM6rYdwhJ3T7kcyMbG5HAdWmtSK/P4Gn5UM7hxgbGeZrjKuWQ+7ZwsCwCN9hR2cerg8M89XonASeCnyFCTGVWRj8ylcTn+ZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602939; c=relaxed/simple;
	bh=MHaaBqN3QNfORxoaQztv7SZ1/NkeQQGNuNly21tYCyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQkE5N4szLnfoLEsZO9B3QM+hKLTQnK2c7eVg0nQxiu7Grqf5ustQNm5X70enHxsaQPLaHsYcyPJHdxARDVSSIQwYSNnTmGDfs2a5+LPbfid6Qf2Aimq4muxs79Sh+iLHoae4haTlQAArLGYVwoFR4tuglyR9qTvLmjGC3JvvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTD9dr3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTD9dr3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAB9C116C6;
	Fri, 20 Feb 2026 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771602939;
	bh=MHaaBqN3QNfORxoaQztv7SZ1/NkeQQGNuNly21tYCyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTD9dr3J+18ttQtijbS2bE/dt/GKdjHpehjI+UljAuYtug7IaXw1pgq5LwpMCtqjI
	 rtB7/VQ/TIOzwBKW2h3CaxFAqzQAqhQqjY6pao6OUp8Vd44EdmMvygJCk5vSNWlVCd
	 ZCSx7dOScYdPqapRtGO5vOmkeWpWcWaLCB5G1QhzemCVjyjFdg13kLXPMrAFkxDnJw
	 T7iIq83NTPyQ0pXg9EfKLNskRWQKGOUbPxtNMUy7YQh+dr5sRAItIlZlZm4y0RMojF
	 hAVC0tatcERu8W4WCootn+AJ/0r9ftB2iDqXNjyg5TOP7aaD1mYjS9NzuDArqDzmPK
	 la14Q0kbKtklw==
Date: Fri, 20 Feb 2026 16:55:36 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Song Liu <song@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Remove duplicate freeing of lockdep classes
Message-ID: <aZhfB7BdtNIJbFwd@macos>
References: <20260107122329.1324707-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107122329.1324707-1-petr.pavlu@suse.com>

On 2026-01-07 13:22, Petr Pavlu wrote:
> In the error path of load_module(), under the free_module label, the
> code calls lockdep_free_key_range() to release lock classes associated
> with the MOD_DATA, MOD_RODATA and MOD_RO_AFTER_INIT module regions, and
> subsequently invokes module_deallocate().
> 
> Since commit ac3b43283923 ("module: replace module_layout with
> module_memory"), the module_deallocate() function calls free_mod_mem(),
> which releases the lock classes as well and considers all module
> regions.
> 
> Attempting to free these classes twice is unnecessary. Remove the
> redundant code in load_module().

I'd even say module_deallocate() handles MOD_DATA properly (deferring
it to the last one) while the first loop was not taking that into
consideration.

> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

