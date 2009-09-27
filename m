Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 27 Sep 2009 13:05:01 -0400 (EDT)
From: Tim Abbott <tabbott@ksplice.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/2] lib: Add generic binary search function to the
 kernel.
In-Reply-To: <200909240941.41479.rusty@rustcorp.com.au>
Message-ID: <alpine.DEB.1.10.0909271303580.14151@dr-wily.mit.edu>
References: <1253626718-18887-5-git-send-email-alan-jenkins@tuffmail.co.uk> <1253726926-5504-2-git-send-email-tabbott@ksplice.com> <200909240941.41479.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


On Thu, 24 Sep 2009, Rusty Russell wrote:

> On Thu, 24 Sep 2009 02:58:45 am Tim Abbott wrote:
> > +void *bsearch(const void *key, const void *base, size_t num, size_t size,
> > +	      int (*cmp)(const void *key, const void *elt))
> > +{
> > +	int start = 0, end = num - 1, mid, result;
> > +	if (num == 0)
> > +		return NULL;
> > +
> > +	while (start <= end) {
> 
> The if (num == 0) line is superfluous.

You are quite right.

	-Tim Abbott
