Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C5146A72;
	Sun,  7 Sep 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757272215; cv=none; b=gDdA0gXyjB3jAoXxtvjJVPkXNcwNjE3oXzEDiA/mYKprEd2VX1efU6qzk53cabnOBpcrnvyH8jDgIk1aLwA1pCzFLHQHCv8guyYIkfNNw1eS31RNTB2KnhE45x0BFo9356Tw/UNIo1JGoYuBjnulsfkOxH6wScCyrOfqB/Yknag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757272215; c=relaxed/simple;
	bh=fojLI4QPu1XEv7MN5SP9flN29H+FvXNVdo+COfODLaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvZWcgV1NObQn+A4n+1xHnwsCkhXB3RUUcpIJWyg1CmRRHMCpabWRpVnI8SzEr6QTMQ5xvmKoMGn11iJOAkv0kYoVzibQ5kieLsPmcdbWqd3ckXwrZ8gdbD+Xjp2YUEao8eiaqWi/A1yerok1D7kjSUP4DvYNDgYbp+PJeERBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8KtRb/i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8KtRb/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951FBC4CEF0;
	Sun,  7 Sep 2025 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757272214;
	bh=fojLI4QPu1XEv7MN5SP9flN29H+FvXNVdo+COfODLaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8KtRb/if/MQRChc47RzA0V21ubue9mWB/cUBxeUn0cEC/dtdWvt7Osz+FDOUe9lR
	 6ULsx2vS3echqTrVHiubl/P/Ss1G0FM7+rCbTHyjlqG2cSkbHtNDR923zahd6PgKmP
	 SCfSPnaIU1B2j7+Dz4eyn0jtstfI18UV6zjnVbM4dCXrPW5ZPsp+dykiIN0p14KGyX
	 z3SzH5x5qfOYuYdAWbYOx/okgL/5PeQpMeHI+VoEZzu7U8F8f5Rnewk+uTmngsX8gT
	 veBYbcFWzNd+AhqymVHNAnh/jKOJrfFy6d9gzVlygq5d9aJIFHt9x2Ur0XQ3KFtlEQ
	 tgBEJo4QLfE9A==
Date: Sun, 7 Sep 2025 12:10:12 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Fidal Palamparambil <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing : Fix multiple issues in trace_printk module
 handling
Message-ID: <aL3YlEZylChyTE5K@bombadil.infradead.org>
References: <20250907135201.760-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907135201.760-1-rootuserhere@gmail.com>

On Sun, Sep 07, 2025 at 05:52:01PM +0400, Fidal Palamparambil wrote:
> From: Fidal palamparambil <rootuserhere@gmail.com>
> 
> This commit addresses several bugs and potential issues in the
> trace_printk module format handling code:
> 
> 1. Memory leak fix: In hold_module_trace_bprintk_format(), ensure
>    proper cleanup when format string allocation fails by setting
>    tb_fmt to NULL after freeing it to prevent memory leaks.
> 
> 2. NULL pointer dereference prevention: Added comprehensive NULL checks
>    in t_show() function before dereferencing format pointers to prevent
>    kernel crashes.
> 
> 3. Input validation: Added NULL check in trace_is_tracepoint_string()
>    to prevent potential NULL pointer dereference when called with
>    invalid input.
> 
> 4. Type safety: Fixed type casting in t_show() to use proper
>    unsigned long casting for pointer arithmetic, ensuring correct
>    pointer handling across different architectures.
> 
> 5. Error handling: Fixed type mismatch in init_trace_printk_function_export()
>    by properly handling struct dentry pointer return from tracing_init_dentry()
>    and using IS_ERR_OR_NULL() for comprehensive error checking.
> 
> 6. Code robustness: Added additional pointer validation throughout
>    the code to handle potential edge cases and improve overall stability.
> 
> 7. Memory safety: Ensured consistent handling of format pointers
>    when memory allocation failures occur, preventing use-after-free
>    and other memory corruption issues.
> 
> These fixes improve the stability and reliability of the trace_printk
> infrastructure, particularly when dealing with module loading/unloading
> and format string management.
> 
> Reported-by : kernel test robot <lkp@intel.com>
> Closes : https://lore.kernel.org/oe-kbuild-all/202509071540.GTxwwstz-lkp@intel.com/
> Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>

Stop, at this point after being told to stop, your intent is clear: to bug.

Go away. You're on my ignore list now.

  Luis
