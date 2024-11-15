Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697E15383B;
	Fri, 15 Nov 2024 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645661; cv=none; b=Q7kTWCMTU6wfBd6RbI1bjJOaPWd+MM9Ds3+KJArdhdn+ENk9KAXRca2djXh3r6hc0MMxh480PDF6W2dGDE4HTLMURjHanSqqadQPBf7WfghYejYjRkmSdtKhnAeClZOqaCNJ55pTaWREB7n7iUfm+6n2yhZLhCLiy+fLnLZzPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645661; c=relaxed/simple;
	bh=lrqMIMGoiYDcVE0ztiCdrgZFwWfWY350mBjHkO7aYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwP+tE/qCHxZ4vFMtIqYfjieBMoThTCmeTL0DRK0h6Ma+rbhejpbdPmrBO+8KCaairCb+nXAG6Hrkfof1+TQnhhU21wYaAJe622IXB2oUJHz5u/eRZuUsDgdsv9Ug1zKUJTYhSZWGdrgMpgjwrYXakYMMvWS5flUwIgjmthGgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1cKHf49B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cKHf49B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE35BC4CECF;
	Fri, 15 Nov 2024 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731645661;
	bh=lrqMIMGoiYDcVE0ztiCdrgZFwWfWY350mBjHkO7aYEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1cKHf49BVbua74yIKtyhaiiSMSD4upSoUpY4iF1uhzq5OI3sOsvuQAsTfvWbgh0M8
	 SxK9jQoDod+KLpOKh12+rnZX6hlxqdL7bKCGgPSU1FzCJtDjnH4razUZEkjjtsMRNV
	 Z88Q5/6GrmSGw3tFg0bhiUSPhTcRNdDRUEATHqZM=
Date: Fri, 15 Nov 2024 05:40:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 1/2] module: Put known GPL offenders in an array
Message-ID: <2024111548-footman-bulldog-238e@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <20241114103133.547032-5-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114103133.547032-5-ukleinek@kernel.org>

On Thu, Nov 14, 2024 at 11:31:33AM +0100, Uwe Kleine-König wrote:
> Instead of repeating the add_taint_module() call for each offender, create
> an array and loop over that one. This simplifies adding new entries
> considerably.
> 
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> ---
>  kernel/module/main.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
