Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE115223;
	Sun,  7 Sep 2025 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208152; cv=none; b=hLABuGeIT8r+Ywl2hlNrotzX0s8H2Aw7VmhFF+kckZRoVI27rwX/jFJrYB45x/gpNWB1vxCg/KT2y8lip1nuBSZbwKxRuax5WOAw3u7scE1MBdZ+gvsTakIpxOTc59hdDIbL15S+WqDyC8a/i5sB0OgFvDGtC1BDigluuOgvEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208152; c=relaxed/simple;
	bh=45Bs4F7BJWWXe0lTh1YwTRJqVvRsq2E/6m0TjjoFMyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKQzYYp2U0KPqdbnaHcya5K9LRzntv7TMrPB9FJTWRpBTQiUz99vglN7+dJZyvZ2s4epqv8xgGThGXat37tK3WvFsR2wQ4Bs1mZIc4IuqKp58mDh/LMqm6gn+ChTV3S8D/lKEc1HsC2UM2uplnEMVQNXqCURvhu5uUSFB/xtg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9aVYrTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9aVYrTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD50C4CEE7;
	Sun,  7 Sep 2025 01:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208151;
	bh=45Bs4F7BJWWXe0lTh1YwTRJqVvRsq2E/6m0TjjoFMyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9aVYrTmzIOVT63bKuTe2jjbQhrmGJIR7mDNHjc6KQG2WJ98pz5GgC43r+vXMICcV
	 BYtw3XGyox6/6+xzfktAxdcJ/mdw4X9hIcRZiaC6b0aY6lGzgl3LgwaJcPB0/k68JM
	 LZNe4nrsz2NKe5HSI1DDf9NFZxF6MKLf2KHZn2eLIcXHe3fmGHpCz1iTARJVw+4GN1
	 dtskUxyfs9i+5VkSVxt3RnAyGxTm5+AJkVSh38b6yREhsWhYKxCiuKVF+OU/m0YD1D
	 Sj5qqraUQ23ZrGp4fEC0dQB14D+GBYeQfrcOkkSU5GWvYeUI/5+bPwyQtczU2nMUAM
	 NmBtfGtldoeIg==
Date: Sat, 6 Sep 2025 18:22:29 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Fidal Palamparambil <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: debug: Fix multiple issues in debug controller
 implementation
Message-ID: <aLzeVZmxuNH1sxCq@bombadil.infradead.org>
References: <20250906124417.793-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906124417.793-1-rootuserhere@gmail.com>

On Sat, Sep 06, 2025 at 04:44:17PM +0400, Fidal Palamparambil wrote:
> From: Fidal palamparambil <rootuserhere@gmail.com>
> 
> This commit addresses several issues in the cgroup debug controller:
> 
> 1. Memory leak protection in current_css_set_cg_links_read():
>    - Initialize name_buf to NULL and use proper error handling with goto
>    - Ensure memory is freed in all code paths
> 
> 2. RCU locking correctness:
>    - Use lockdep_is_held() for proper lock dependency tracking in
>      rcu_dereference_protected() calls
>    - Ensure proper locking context is passed to RCU checks
> 
> 3. Buffer size safety:
>    - Remove off-by-one in snprintf() size calculation
>    - Use sizeof(buffer) instead of sizeof(buffer)-1
> 
> 4. Code robustness:
>    - Add proper initialization of variables
>    - Use consistent error handling patterns
>    - Fix potential integer underflow in extra reference calculation
> 
> The debug controller is for internal debugging only, but these fixes
> ensure it doesn't introduce stability issues or memory leaks when
> used for debugging purposes.
> 
> Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>

We really need to just ban you.

 Luis
