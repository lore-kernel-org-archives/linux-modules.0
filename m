Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235C23DE85;
	Thu,  6 Mar 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280954; cv=none; b=QtzA7+0gf+foKAbk8eZHnPQw4O7KyXJ/95cyQpp/hLN4Nuw9DUqnWxWiyZzgn3y+LdOnfUpgdLfSRsO236vZtE9zqBWRx+cQytirQjC0G//TNGtjJeBtups/KXFw4WQzDOpPsZ7R9sPnYnOfN+8ywNtpWpPY5JpAoENYnh8pbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280954; c=relaxed/simple;
	bh=uNGL0ISzvVLuK+K+AYnkGnjVUpQ2UXX2zV6qC1xuiMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s45P5te+NvKEGPYEUjybokEGWsDuGVIHxsKy4IXK6vy1gmahEgMSdjbB7DXWiTHsklZBvRJXdgfSKqk7eWhS3LGo1DSnpmTwip6uqcug3t1tX62p606G11xTj2TfLvZrpuEepGXtzHnRmpqWJ0h+hQStRVqBLCT7yg+qdOYlb88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6526C4CEE0;
	Thu,  6 Mar 2025 17:09:13 +0000 (UTC)
Date: Thu, 6 Mar 2025 12:09:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update the MODULE SUPPORT section
Message-ID: <20250306120914.7059a06a@gandalf.local.home>
In-Reply-To: <20250306162117.18876-1-petr.pavlu@suse.com>
References: <20250306162117.18876-1-petr.pavlu@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 17:20:59 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Change my role for MODULE SUPPORT from a reviewer to a maintainer. We
> started to rotate its maintainership and I currently look after the modules
> tree. This not being reflected in MAINTAINERS proved to confuse folks.
> 
> Add lib/tests/module/ and tools/testing/selftests/module/ to maintained
> files. They were introduced previously by commit 84b4a51fce4c ("selftests:
> add new kallsyms selftests").
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

As one of the confused, thanks for doing this ;-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
