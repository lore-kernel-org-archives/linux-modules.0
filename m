Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64404 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbaDALNS (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 1 Apr 2014 07:13:18 -0400
Date: Tue, 1 Apr 2014 08:13:13 -0300
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Marek <mmarek@suse.cz>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/2] libkmod: Ignore errors from softdeps
Message-ID: <20140401111312.GJ1123@intel.com>
References: <1396271931-7431-1-git-send-email-mmarek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1396271931-7431-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Michal,

On Mon, Mar 31, 2014 at 03:18:50PM +0200, Michal Marek wrote:
> Before we had softdeps, the usual idiom was
> 
> install foo /sbin/modprobe bar; /sbin/modprobe --ignore-install foo
> 
> ignoring errors from the first modprobe invocation. This also matches
> the behavior of module-init-tools' implementation of softdep.
> ---

Applied. Thanks.

-- 
Lucas De Marchi
