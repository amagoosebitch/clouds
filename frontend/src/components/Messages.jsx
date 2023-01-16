import React from 'react'

function Messages(properties) {
    return (
        <div className="flex flex-col mx-auto">
            <p className='text-lg'>
                Автор: {properties.name}
            </p>
            <p className='text-sm'>
                Анекдот: {properties.message}
            </p>
            <hr className='mt-2' />
        </div>
    )
}

export default Messages