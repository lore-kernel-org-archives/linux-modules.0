Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E505223;
	Sun,  7 Sep 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208185; cv=none; b=PW+f3WWajZ/a6gmhAQenEDXadf6E5cMMwWgFbGm+zhveCbvAtxRNaBvwbqkUySEABg4dL8SFBRzNV+wYIcH8N2cdZK8rqg6XUUeVS9qjrQqe5XAWatjD+xGyFo9LhTml/AnSDOM6WdmP6ttCU4yTRqmnP015KPmQUEJknsr3DrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208185; c=relaxed/simple;
	bh=eAIG6KDBAl3KeiZLPafKoDkBVu1M4D6f7XCBHVzmX7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mctge9k7MG04JZV8ZY/H7q+6RIHMs0lgE9iPdiIkmiKr5jJcfxkRg2FWCUuhmmXP3RBoOAXvbISM58Qlg1ENGSYcr9aW66NIFO/rN0EwW6oU1s+okTzhN2rAqgtGZoSDLGIk6Yu/KooJjAD8XcrpECTkHU44qIsBkgIQ7cYSloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhvJvDdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhvJvDdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18BCC4CEE7;
	Sun,  7 Sep 2025 01:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208184;
	bh=eAIG6KDBAl3KeiZLPafKoDkBVu1M4D6f7XCBHVzmX7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhvJvDdYDa+QWZjXtz2LJc5LnKhbkgRARHrGuqIQ38O0MOibXes66MoJHhfcc8HX9
	 1B2MoAhJKhCPdOabvSUId3hVpjp8TZzEaOsdsX4RizKnF8kwOYlbOzND+ddzyKOT5V
	 PIidbStTVoD1FCTwml3q4LTes++M0HkqYJ2aGScOQDuVKfRsXxxRqsvZUJBz33L8cu
	 KJqcWZf9XrlDXSa/yQVkxIQqQEfkKOiXjm9n3NjJtrSZQCVVMJlmooMOjUQEku5rFL
	 DuW0CsfKZR5d3IJpLUtlHWbgksRWlvY5kl7oQUqbGPBkTY7b9rByvUVB2XW7eiwtpu
	 oV9ED04q6jq2Q==
Date: Sat, 6 Sep 2025 18:23:03 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Fidal Palamparambil <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobe_event_gen_test : Fix error handling and resource
 cleanup
Message-ID: <aLzed3HeWD3T1WIM@bombadil.infradead.org>
References: <20250906131559.200-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906131559.200-1-rootuserhere@gmail.com>

On Sat, Sep 06, 2025 at 05:15:59PM +0400, Fidal Palamparambil wrote:
> From: Fidal palamparambil <rootuserhere@gmail.com>
> 
> This commit addresses several issues in the kprobe event generation test module:
> 
> 1. Fixed NULL pointer management in error paths where trace_event_file pointers
>    were not properly set to NULL after errors, potentially causing double-free
>    or use-after-free issues.
> 
> 2. Added comprehensive cleanup for the kprobe event when kretprobe initialization
>    fails in kprobe_event_gen_test_init(). Previously, a failed kretprobe creation
>    would leave the kprobe event dangling.
> 
> 3. Enhanced error handling consistency between kprobe and kretprobe test functions,
>    ensuring both follow the same pattern for resource cleanup.
> 
> 4. Fixed the error handling flow in test_gen_kprobe_cmd() and test_gen_kretprobe_cmd()
>    to properly set trace_event_file pointers to NULL when errors occur after
>    event creation but before successful completion.
> 
> The changes ensure proper resource management and prevent potential memory
> corruption or leaks during module initialization and cleanup.
> 
> Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>

Please just stop.

 Luis
