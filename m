Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16739EEB2;
	Tue,  7 Jan 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208813; cv=none; b=Vrz59e6f5whUNRAjpp8tjZHmXGoWWhS9IWOvoJl2oACqwdwKCqgoTkpqElLw9oZP7F+XA1QbLRV+jLasax8S70AzQfQeo8O0w7C8EPnqxw49FsquN9kGplc7Y5oE2nmXrpJ5+4s2knPynciqLM8G+MVMqUToxHEpgC421+3ba6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208813; c=relaxed/simple;
	bh=xyYLNDQCGZPfnhHO/2SmdY256WPnKEfpvNumyWQ6dxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhqivzTBwIOY2YJAsbudyRBDJnrTrv40SXzYK2XpR8eneglEkO+I5A4hhK7Pxi6e3JCA2XtYuSNg4fLbJ6fvwAPV35BKuMZv70mTgBxy0CcMI4mXo85DpRwuKOr4SEE62sJVRhmQDUsGLvAUYBjdxc7UGGcU3An1Osa1Sk5CVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biFd9cI+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biFd9cI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712ADC4CED2;
	Tue,  7 Jan 2025 00:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736208812;
	bh=xyYLNDQCGZPfnhHO/2SmdY256WPnKEfpvNumyWQ6dxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biFd9cI+PZjzaZCYoGeOjLehURgJOE4iJI3VVIdjibzTWlcD7Gh2tcQG22PhaKppA
	 C9jCaCJq2zVkfGzM4kcenmq9ssM2QJiYEKYaKnASWdUeo/vnaAnB3MjHlzRq4sBKvZ
	 UfgM+E4pHMMbsGJLKGVvHtgcrpKW290WJDPcR59/Rp7M/CoT3LJshvlCsmRtvBklL/
	 2rqDnzzjxPhEC4NNazOXwiS9emd54jMZELYE62fsH2ztJOXeojnJGh+NMoAMUSqgFd
	 HlyQtMjqqMi5iBSPdKG4ctq/QHrqs7LUgJ0VJQwVEC4kaecFZ5mQ17qXqrA2K2Ld3r
	 izvC1m1V2Y5gA==
Date: Mon, 6 Jan 2025 16:13:29 -0800
From: Kees Cook <kees@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 0/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
Message-ID: <202501061610.203636A9C@keescook>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
 <f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>

On Fri, Jan 03, 2025 at 05:13:32PM +0100, Petr Pavlu wrote:
> On 12/5/24 20:46, Christophe Leroy wrote:
> > This series reworks module loading to avoid leaving the module in a
> > stale state when protecting ro_after_init section fails.
> > 
> > Once module init has succeded it is too late to cancel loading.

Is there at least a big WARN about the ro failing? That should let more
sensitive system owners react to the situation if it looks like an
active attack on memory protections.

(And maybe we should set a TAINT flag, but perhaps this is too specific
a failure mode for that?)

Also, why is it too late to cancel? Can we set the module to the
"Unloading" state to stop any dependent modules from loading on top of
it, and then request it unload?

-- 
Kees Cook
