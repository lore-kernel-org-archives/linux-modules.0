Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B35223;
	Sun,  7 Sep 2025 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208233; cv=none; b=sLupdPz+KMEiv+lZNPR7t/7qVH2GH9KVOZN9i7HujZj6qoDkhjC6nisGoxTedECfG/j6RcTXA3oAzsHBeFomjSJavn7J25fzCTx5yj9d33Z9DQWtAbfNTBpnvtK1ws/ECd7XHqKay8xfYOAvqr+JRk90E3UkHJtviqxmfpA17wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208233; c=relaxed/simple;
	bh=zP8CFwnQMPCMWFqs0UicKvVL7hZMnq0k0NYIXb0eRho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tor7XXx1MTr0r7DQpDBbETD+Z7N1G75kLQW9sa0ZAtBbUpJTf7apPcrLf2kOBxrZQffSowP+ggQm1Yiy0kpbWvw2qWunsFe4Wuku8AUN+Kqh6c8qdXhT7v/TYL0l9O+1+gk8vLxro3YAsUtOr2vahHaiQcPL3GDxj2722iDP++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwbUr28j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwbUr28j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A005EC4CEE7;
	Sun,  7 Sep 2025 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208232;
	bh=zP8CFwnQMPCMWFqs0UicKvVL7hZMnq0k0NYIXb0eRho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwbUr28j+hVItZ0A4m+q/29KM/hI+4ITMtIFXYB9i5eYAhyz8VOt7dqf+GFJLPV39
	 WVb42y6s4SGkRFyTg0c0k463wxLhhb9aaJJwhtX9g27a9etbBciOTFLRDQpEr8f++m
	 W8F3tn8vJh9pyuY9UU0ud8XK0Jlq8vOkNRbuGcil1FuhryhPCYu3m8Py8hgUl+G/Ip
	 RLwaUKLi6HSpA1KT8/uDCsj/zyQNR5CxYw+dYcGaDRYqB6qvZQpLakxayzoUNaS0SQ
	 ssZfUMEm2WxnyBMyPb9NoNEduAcMmefJzF5SyQ3amR9FXDN+cnrLTirX9hfjyPE75G
	 OZDuZfkpRr2CQ==
Date: Sat, 6 Sep 2025 18:23:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Fidal Palamparambil <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix multiple issues in trace_printk module
 handling
Message-ID: <aLzepzAY3SD1B5Ut@bombadil.infradead.org>
References: <20250906134148.55-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906134148.55-1-rootuserhere@gmail.com>

On Sat, Sep 06, 2025 at 05:41:48PM +0400, Fidal Palamparambil wrote:
> From: Fidal palamparambil <rootuserhere@gmail.com>
> 
> This commit addresses several bugs and potential issues in the
> trace_printk module format handling code:
> 
> 1. Memory leak fix: In hold_module_trace_bprintk_format(), ensure
>    proper cleanup when format string allocation fails by setting
>    tb_fmt to NULL after freeing it.
> 
> 2. NULL pointer dereference prevention: Added NULL checks in
>    t_show() function before dereferencing format pointers.
> 
> 3. Input validation: Added NULL check in trace_is_tracepoint_string()
>    to prevent potential NULL pointer dereference.
> 
> 4. Type safety: Fixed type casting in t_show() to use proper
>    unsigned long casting for pointer arithmetic.
> 
> 5. Error handling: Improved error checking in
>    init_trace_printk_function_export() by using IS_ERR() to check
>    dentry pointer.
> 
> 6. Code robustness: Added additional pointer validation throughout
>    the code to handle potential edge cases.
> 
> 7. Memory safety: Ensured consistent handling of format pointers
>    when memory allocation failures occur.
> 
> These fixes improve the stability and reliability of the trace_printk
> infrastructure, particularly when dealing with module loading/unloading
> and format string management.
> 
> Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>

Anothe waste of time. Stop. I'll suggest everyone ignore your patches.

  Luis
