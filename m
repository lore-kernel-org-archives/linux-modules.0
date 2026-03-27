Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A42395242;
	Fri, 27 Mar 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615519; cv=none; b=RHkmEmpHxwdqnc2bhG2AkvANYXYN3Ts4ZN1fUqZKpOvgzcxq//k5uTcN+7sBqvwpuWZ/C7MKMBuYWbvJYJVo701JduvVEwZW0R0WD3Izbm+iwMOL+YFkFPrd6pD5E3JNRJXdCvwo6rQa/LVZnqmg3bTIfJ1NBHNRt7+FGnPvOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615519; c=relaxed/simple;
	bh=Y1SjdljRmAWyBrIR7IQW+FdS/L6hAVNkjQJqw9Y/BVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8Bq2jymlvzeEP8eXFvsXPT8THx8Uolx2o48n6ZKN4nt2D1vDXjO6xEcYRdzWbCOBADkITKdBX078mSAc24DVwdR+s6IZAFC2iZxmt0H7qtrDqNXvfFaZQj54X9a5dRLbJx+G3+vVq/1RkxRr0rdMMpXKyuQIkQwA61ULMiA8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btjJtrVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btjJtrVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D0FC19423;
	Fri, 27 Mar 2026 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774615518;
	bh=Y1SjdljRmAWyBrIR7IQW+FdS/L6hAVNkjQJqw9Y/BVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btjJtrVarcooqnZBfbh1RErC+3MYHhvPudCmFB2+oajs9Sq9/2+lcDpkl0pF55GIw
	 LM33LwzMuvcEsPZGCR1cO0Z2Y3qYOEGo317ZtNNlDvMBRYIiWc+WdQ74lJ57Fy6Lva
	 8lk4bLnYhuCPiYhezjn9NK28zFYLJX84NSqo2/f8=
Date: Fri, 27 Mar 2026 13:44:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <2026032738-brisket-dreadlock-8ddd@gregkh>
References: <2026031341-evolve-repeater-987b@gregkh>
 <d622c70a-f79a-4215-84fb-c5de0a8f6ce5@suse.com>
 <87cy0p5ufl.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cy0p5ufl.fsf@yellow.woof>

On Fri, Mar 27, 2026 at 01:27:26PM +0100, Nam Cao wrote:
> Petr Pavlu <petr.pavlu@suse.com> writes:
> > On 3/13/26 3:20 PM, Greg Kroah-Hartman wrote:
> >> Module "versions" do not make sense as the kernel is built all at once,
> >> the "version" is the overall kernel version number, so modules can not
> >> really be described as having a unique version given that they rely on
> >> the infrastructure of the whole kernel.
> >> 
> >> For now, just make this an "empty" define, to keep existing code
> >> building properly as the tree is slowly purged of the use of this over
> >> time.
> >> 
> >> This macro will be removed entirely in the future when there are no
> >> in-tree users.
> ...
> > The original patch "Add a MODULE_VERSION macro" [1] from 2004 doesn't
> > say much about the motivation for adding module versions, but it does
> > mention that they should be accessible via sysfs. That was implemented
> > a year later in commit c988d2b28454 ("[PATCH] modules: add version and
> > srcversion to sysfs") [2], which primarily discusses use cases related
> > to DKMS, and to administrators + tech support needing to know what is
> > actually loaded on the system. For the latter, I believe srcversion (or
> > something similar) should be sufficient.
> 
> I develop an external module. And our userspace program does rely on
> this to get the module's version on the user's system. This patch would
> break our program.

Why not get the module merged upstream so you don't have this problem
anymore?

> I can change to use a different mechanism. But surely I am not the only
> one who write something that rely on this.

I recommend changing it, as this is not needed in the tree :)

I've been at a conference all week, will respin this patch series next
week and resend, sorry for the delay.

thanks,

greg k-h
