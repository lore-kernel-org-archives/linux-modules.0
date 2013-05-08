MIME-Version: 1.0
In-Reply-To: <20130508001530.GA4432@chengwei-workstation.bj.intel.com>
References: <20130507135453.GA25275@chengwei-workstation.bj.intel.com>
	<CAKi4VAJkZpo-=XxJ9Tnwdt6E9YdHsoQu1s7nU7m5ZUNQmNcp5Q@mail.gmail.com>
	<20130508001530.GA4432@chengwei-workstation.bj.intel.com>
Date: Tue, 7 May 2013 21:50:56 -0300
Message-ID: <CAKi4VAKsHwG1SqTN4oVO_3ysngEO4M0xC--jbZWyY6aedPxb5Q@mail.gmail.com>
Subject: Re: [RFC] Fix the kmod internal list behavior?
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, kmod <linux-modules@vger.kernel.org>
Cc: Yang Chengwei <chengwei.yang@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 7, 2013 at 9:15 PM, Yang Chengwei <chengwei.yang@intel.com> wrote:
> On Tue, May 07, 2013 at 12:14:59PM -0300, Lucas De Marchi wrote:
>> On Tue, May 7, 2013 at 10:54 AM, Yang Chengwei <chengwei.yang@intel.com> wrote:
>> > Hi List,
>> >
>> > I just found that there are some minor issues in kmod iternal list
>> > implementation implemented by libkmod-list.c.
>> >
>> > Say
>> >         1. list_node_append() is identical with list_node_insert_before(),
>> >         so somehow the list_node_append() in fact does "prepend" operation.
>>
>> To append to a circular list, you insert it *before* the first node.
>> So what's wrong here?
>
> Yeap, it's definitely right. I was misunderstanding. :-(
>
>>
>> >
>> >         2. just the same as list_node_append(), kmod_list_append() which
>> >         invokes the former just do "prepend" operation rather than "append".
>>
>> like I said, it's expected, since it's circular. kmod_list_append()
>> expect you to pass the head of the list, so to append to the list you
>> prepend to the first node, but you don't return it as the new head
>> unless it's the first one - check the return code.
>>
>> >
>> > I'd like to fix these internal APIs to do the operation suggested by its
>> > name like
>> >         1. drop list_node_append()
>> >         2. call list_node_insert_after() to do "append" operation
>> >         3. call list_mode_insert_before() to do "prepend" operation
>> >
>> > Since the list here is circular linked, so I think these changes should
>> > not break things except the test cases.
>> >
>> > Any comments are appreciated.
>>
>> Are you analyzing the source code or are you seeing a real problem?
>
> Relax, no real issue found.

Good to know :-)

>
>> It'd be nice to write a small test showing the problem - you can use
>
> So I think it's not necessary to add a dedicate test for list, the
> others somehow use the list, like modinfo test.

On a side note about the current list implementation: one interesting
thing to investigate is how much memory we waste on list nodes and how
we could improve that. One possible answer is by using inlined nodes
like kernel's.

In some places we use kmod_list very heavily like in depmod. Last time
I checked I remember a great portion of the memory used just to store
the list nodes. If you would like to improve this part, or at least
profile it, it would be very nice :)


Lucas De Marchi
